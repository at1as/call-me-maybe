class ConversationsController < ApplicationController
  def new
    @conversation = Conversation.new
    @date         = params[:date]
    @timezone     = params[:timezone] || "Pacific Time (US & Canada)"
  end

  def index
    @conversations = Conversation.all

    render 'index'
  end

  def create
    fields = conversation_params

    if params[:start_time_time_component].nil? # Param is not part of Conversation model
      flash[:error] = "Invalid Date"
      redirect_to conversations_path and return
    end

    fields[:start_time] += " " + params[:start_time_time_component] + ":00 " + (params[:timezone] || DEFAULT_TIMEZONE)
    
    if fields[:reminder]
      fields[:reminder] = DateTime.parse(fields[:start_time]) - fields[:reminder].to_i.minutes
    end
    
    @conversation = Conversation.new(fields)
    @date = params[:date]
    
    if @conversation.save
      flash[:success] = "Timeslot Booked!"
      invoke_creation_jobs(fields)
      
      redirect_to conversations_path
    else
      flash[:error] = "Error booking timeslot. Ensure all fields "
      redirect_to request.referrer
    end
  end

  def show
    logged_in_user

    @conversation = Conversation.find(params[:id])
    render 'show'
  end

  def destroy
    logged_in_user
    # TODO: delete delayed notification job

    @conversation = Conversation.find(params[:id])
    @conversation.destroy

    Delayed::Job.find(self.delayed_job_id).destroy if self.delayed_job_id

    invoke_deletion_job
    redirect_to users_path_url(current_user), :flash => { :success => "Conversation removed from schedule" }
  end

  private
    def conversation_params
      params.require(:conversation).permit(:guest_email, :reminder, :start_time, :message, :date, :day, :time, :phonenumber)
    end

    def invoke_creation_jobs(fields)
      sms_alert_job(fields)
      mailer_scheduled_job(fields)
    end

    def invoke_deletion_job
      mailer_cancelled_job
    end

    def sms_alert_job(fields)
      if fields[:phonenumber] && fields[:reminder]
        sms_alert_time = fields[:reminder]
        SmsReminderJob.set(wait_until: sms_alert_time).perform_later(fields[:phonenumber], fields[:start_time])
      end
    end

    def mailer_scheduled_job(fields)
      email_alert_time = DateTime.parse(fields[:start_time]) - 5.minutes
      MailVideoUrlJob.set(wait_until: email_alert_time).perform_later(fields[:guest_email], fields[:start_time])
    end

    def mailer_notify_admin_job(fields)

    end

    def mailer_cancelled_job
      MailVideoCancellationJob.perform_later(@conversation.guest_email, @conversation.start_time.to_s)
    end
end

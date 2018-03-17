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
      invoke_creation_jobs(fields, @conversation.id)
      
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

    invoke_deletion_jobs
    redirect_to users_path_url(current_user), :flash => { :success => "Conversation removed from schedule" }
  end

  private
    def conversation_params
      params.require(:conversation).permit(:guest_email, :reminder, :start_time, :message, :date, :day, :time, :phonenumber)
    end

    def invoke_creation_jobs(fields, conversation_id)
      sms_reminder_job(fields, conversation_id)
      mailer_scheduled_job(fields, conversation_id)
      mailer_send_url_job(fields, conversation_id)
    end

    def invoke_deletion_job
      mailer_cancelled_job
    end

    def sms_reminder_job(fields, conversation_id)
      return unless fields[:phonenumber] && fields[:reminder]

      SmsReminderJob.set(wait_until: fields[:reminder]).perform_later(
        fields[:phonenumber],
        fields[:start_time],
        "conversation_id=#{conversation_id}"
      )
    end
    
    def mailer_scheduled_job(fields, conversation_id, conversation_id)
      MailVideoScheduledJob.perform_now(
        fields[:guest_email],
        fields[:start_time],
        "conversation_id=#{conversation_id}"
      )
    end
    
    def mailer_send_url_job(fields, conversation_id)
      email_alert_time = DateTime.parse(fields[:start_time]) - 5.minutes
      MailVideoUrlJob.set(wait_until: email_alert_time).perform_later(fields[:guest_email], fields[:start_time])
    end

    def mailer_cancelled_job
      MailVideoCancellationJob.perform_later(@conversation.guest_email, @conversation.start_time.to_s)
    end
end

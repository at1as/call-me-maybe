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
    fields[:start_time] += " " + params[:start_time_time_component]

    @conversation = Conversation.new(fields)
    @date = params[:date]
    
    if @conversation.save
      flash[:success] = "Timeslot Booked!"
      redirect_to conversations_path
    else
      render 'index'
    end
  end

  private
    def conversation_params
      params.require(:conversation).permit(:guest_email, :reminder, :start_time, :message, :date, :day, :time)
    end

end

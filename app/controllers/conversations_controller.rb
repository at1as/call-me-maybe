class ConversationsController < ApplicationController
  
  def new
    @conversation = Conversation.new
    @date = params[:date]
  end

  def index
    @conversations = Conversation.all
    
    render 'index'    
  end

  def create
    @conversation = Conversation.new
    @date = params[:date]

    if @company.save
      flash[:success] = "Timeslot Booked!"
      redirect_to conversations_path
    else
      render 'new'
    end
  end

  private
    def conversation_params
      params.requre(:conversation).permit(:guest_email, :reminder, :start_time, :message, :date)
    end

end

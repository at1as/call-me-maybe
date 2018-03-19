class UsersController < ApplicationController

  before_action :logged_in_user
  
  SCHEDULE_GRACE_PERIOD = 5.minutes

  def show
    unless current_user.id == params[:id].to_i
      flash.now['alert-danger'] = 'Please log in'
      redirect_to conversations_path and return
    end

    @user = User.find(params[:id])
    @conversations = Conversation.select { |x| x["start_time"] > DateTime.now - SCHEDULE_GRACE_PERIOD }.sort_by { |x| x["start_time"] }
  end

end

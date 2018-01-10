class UsersController < ApplicationController

  before_action :logged_in_user

  def show
    if current_user.id != params[:id].to_i
      flash.now['alert-danger'] = 'Please log in'
      redirect_to conversations_path
    end

    @user = User.find(params[:id])
    @conversations = Conversation.select { |x| x["start_time"] > DateTime.now }.sort_by { |x| x["start_time"] }
  end

end

class ChatController < ApplicationController
  def index
    @token = params[:token]
    @user  = params[:user]
    @roomname = "Call Me Maybe"

    render 'index'
  end
end

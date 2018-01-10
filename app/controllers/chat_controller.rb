class ChatController < ApplicationController

  def index
    if logged_in?
      @token = get_token
      @user  = current_user.email
    else
      @token = params[:token]
      @user  = params[:user]
    end
    
    @roomname = "Call Me Maybe"
    render 'index'
  end

  private

    def get_token
      @twilio_client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      @video_grant   = Twilio::JWT::AccessToken::VideoGrant.new

      @token = Twilio::JWT::AccessToken.new(
        ENV['TWILIO_ACCOUNT_SID'],
        ENV['TWILIO_API_KEY_SID'],
        ENV['TWILIO_SECRET'],
        [@video_grant],
        identity: current_user.email,
        ttl: 3600
      ).to_jwt
    end
end

require 'twilio-ruby'

class MailVideoUrlJob < ApplicationJob
  queue_as :default

  def perform(email_address, start_time)
    @twilio_client    = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    @video_grant      = Twilio::JWT::AccessToken::VideoGrant.new
    @video_grant.room = "Call Me Maybe" #"Hello #{email_address}!"

    @token = Twilio::JWT::AccessToken.new(
      ENV['TWILIO_ACCOUNT_SID'],
      ENV['TWILIO_API_KEY_SID'],
      ENV['TWILIO_SECRET'],
      [@video_grant],
      identity: email_address
    ).to_jwt


    GuestMailer.video_url_video(email_address, start_time, @token).deliver_now
  end
end

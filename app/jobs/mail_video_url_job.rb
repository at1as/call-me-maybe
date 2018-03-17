require 'twilio-ruby'

class MailVideoUrlJob < ApplicationJob
  queue_as :default

  MAX_SUPPORTED_TTL = 86_400

  def perform(email_address, start_time, conversation_id)
    @twilio_client    = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    @video_grant      = Twilio::JWT::AccessToken::VideoGrant.new
    @video_grant.room = "Call Me Maybe"


    @token = Twilio::JWT::AccessToken.new(
      ENV['TWILIO_ACCOUNT_SID'],
      ENV['TWILIO_API_KEY_SID'],
      ENV['TWILIO_SECRET'],
      [@video_grant],
      identity: email_address,
      ttl: MAX_SUPPORTED_TTL
    ).to_jwt

    GuestMailer.video_url_email(email_address, start_time, @token).deliver_now
  end
end

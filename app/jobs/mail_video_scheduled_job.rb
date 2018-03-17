class MailVideoUrlJob < ApplicationJob
  queue_as :default

  MAX_SUPPORTED_TTL = 86_400

  def perform(email_address, start_time)
    GuestMailer.video_scheduled_email(email_address, start_time).deliver_now
  end
end

class MailVideoCancellationJob < ApplicationJob
  queue_as :default

  def perform(email_address, start_time)
    GuestMailer.cancel_video_chat_email(email_address, start_time).deliver_now
  end
end

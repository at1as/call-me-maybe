require 'twilio-ruby'

class SmsReminderJob < ApplicationJob
  queue_as :default

  def perform(to_number, scheduled_time)
    client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    client.api.account.messages.create(
      from: '+12018841896',
      to:   to_number,
      body: "Hey! You've got an upcoming video chat scheduled with Jason at #{scheduled_time}. Check your email 5 minutes before for a link"
    )
  end
end

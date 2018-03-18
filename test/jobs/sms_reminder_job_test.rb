require 'test_helper'

class SmsReminderJobTest < ActiveJob::TestCase
  # See https://www.twilio.com/docs/api/rest/test-credentials for test numbers
  test 'that sms is sent' do
    conversation_id = 1
    SmsReminderJob.perform_now("+14152019999", "2018-01-01 18:50 -800", conversation_id)
  end

  test 'that sms job can be enqueued' do
    ENV["TWILIO_FROM_NUMBER"] = "+15005550006"
    
    assert_enqueued_jobs 0
    SmsReminderJob.perform_later("+14152019999", "2018-01-01 18:50 -800", 1)
    assert_enqueued_jobs 1
    SmsReminderJob.perform_later("+14152019999", "2018-01-01 18:50 -800", 2)
    assert_enqueued_jobs 2
  end
end

require 'test_helper'

class SmsReminderJobTest < ActiveJob::TestCase
  # See https://www.twilio.com/docs/api/rest/test-credentials for test numbers
  test 'that sms is sent' do
    SmsReminderJob.perform_now("+14152019999", "2018-01-01 18:50 -800")
  end

  test 'that sms job can be enqueued' do
    assert_enqueued_jobs 0
    SmsReminderJob.perform_later("+14152019999", "2018-01-01 18:50 -800")
    assert_enqueued_jobs 1
    SmsReminderJob.perform_later("+14152019999", "2018-01-01 18:50 -800")
    assert_enqueued_jobs 2
  end
end

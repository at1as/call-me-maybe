require 'test_helper'

class SmsReminderJobTest < ActiveJob::TestCase
  # See https://www.twilio.com/docs/api/rest/test-credentials for test numbers
  test 'that sms is sent' do
    SmsReminderJob.perform_now("+14152019999", "2018-01-01 18:50 -800")
  end
end

require 'test_helper'

class MailVideoUrlJobJobTest < ActiveJob::TestCase
  test 'that job can be invoked' do
    conversation_id = 3
    MailVideoUrlJob.perform_now("hello@exampl.com", "2018-01-01 18:50 -800", conversation_id)
  end

  test 'that email job can be enqueued' do
    assert_enqueued_jobs 0
    MailVideoUrlJob.perform_later("hello@exampl.com", "2018-01-01 18:50 -800", 1)
    assert_enqueued_jobs 1
    MailVideoUrlJob.perform_later("hello@exampl.com", "2018-01-01 18:50 -800", 20)
    assert_enqueued_jobs 2
  end
end

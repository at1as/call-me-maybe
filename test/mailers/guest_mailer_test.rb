require 'test_helper'

class GuestMailerTest < ActionMailer::TestCase
  test "video url email" do
    email = GuestMailer.video_url_email("hello@world.com", DateTime.now, token: "abcdefghijklmnopqrstuvwxyz")

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['hello@world.com'], email.to
    # assert_equal read_fixture('video_url_email.rb').join, email.body.to_s
  end
end

require 'test_helper'

class ConversationTest < ActiveSupport::TestCase
  def compare_dates(date1, date2)
    assert DateTime.parse(date1.to_s).to_i == DateTime.parse(date2.to_s).to_i
  end

  test "should not save without params" do
    conversation = Conversation.new
    assert_not conversation.save, "Saved conversation without params"
  end

  test "should save with params required params" do
    conversation = Conversation.new(start_time: Time.now, guest_email: "hello@world.com")
    assert conversation.save, "Conversation not saved, with valid params"
  end

  test "should save all params" do
    reminder_date = "Sat, 02 Jan 2010 00:00:00 PST -08:00" #Date.new(2010, 01, 02) #DateTime.now #"Sun, 07 Jan 2018 22:38:17 PST -08:00"
    start_date = "Sat, 02 Jan 2010 00:00:00 PST -08:00" #Date.new(2010, 01, 02) #DateTime.now #"Sun, 07 Jan 2018 23:38:17 PST -08:00"

    conversation = Conversation.new(
      guest_email: "hello@world.com",
      video_url: "VIDEO",
      reminder: reminder_date,
      start_time: start_date,
      phonenumber: "14445556677"
    )

    assert conversation.save, "Conversation not saved, with valid params"
    assert_equal conversation.guest_email, "hello@world.com"
    assert_equal conversation.video_url, "VIDEO"
    compare_dates conversation.reminder, reminder_date
    compare_dates  conversation.start_time, start_date
    assert_equal conversation.phonenumber, "14445556677"
  end
end

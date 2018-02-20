require 'test_helper'

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get conversations_path, params: { date: "2017-01-02" }
    assert_response :success
  end

  test "should get new" do
    get new_conversation_path, params: { date: "2017-01-02" }
    assert_response :success
  end

  # TODO: Catch exceptions for missing params
  test "should not create new conversation without params" do
    post conversations_path, params: { conversation: { guest_email: "hello@world.com" } }
    assert_response :failure
  end

  test "should create new conversation with all required params" do
    post conversations_path, params: { conversation: { guest_email: "hello@world.com", start_time: Time.now} , start_time_time_component: "18", conversation_timezone: "Pacific Time (US & Canada)" }
    assert_response :redirect
  end
end

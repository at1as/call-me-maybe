require 'test_helper'

class ChatControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get chat_new_url
    assert_response :success
  end

end

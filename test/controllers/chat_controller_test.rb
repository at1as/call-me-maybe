require 'test_helper'

class ChatControllerTest < ActionDispatch::IntegrationTest
  test "should get page" do
    get chat_path
    assert_response :success
  end

  test "should get page with params" do
    get chat_path, params: { token: "TOKENTOKEN", user: "hello@world.com", start_time: "2012-01-02" }
    assert_response :success

    assert @response.body.include? "TOKENTOKEN"
    assert @response.body.include? "hello@world.com"
  end
end

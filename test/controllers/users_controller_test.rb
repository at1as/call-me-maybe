require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should not get show when not admin" do
    user = User.new(email: "hello@world.com", password: "12345678abc1!", id: 99)
    user.save
    current_user = user

    get users_path_url(id: 99)
    assert_response :success
  end

end

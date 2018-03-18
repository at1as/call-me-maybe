require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should not get show when not logged in" do
    get users_path_url(id: 101)
    
    assert_response :redirect
    #assert_redirected_to "/conversations"
  end

  test "should not get show for other user" do
    user = User.new(email: "hello@world.com", password: "12345678abc1!", id: 99)
    user.save
    current_user = user

    get users_path_url(id: 100)
    assert_response :redirect
    #assert_redirected_to "/conversations"
  end

  test "should get show for current user" do
    user = User.new(email: "hello@world.com", password: "12345678abc1!", id: 100)
    user.save
    current_user = user

    get users_path_url(id: 100)
    assert_response :redirect
    assert_redirected_to "/admin"
  end
end

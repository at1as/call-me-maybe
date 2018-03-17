require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should not save without params" do
    user = User.new
    assert_not user.save, "Saved conversation without params"
  end
  
  test "should save with required params" do
    user = User.new(email: "hello@world.com", password: "12345678abc1!")
    assert user.save, "Conversation did not save with valid params"
  end
end

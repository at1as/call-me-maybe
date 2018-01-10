require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get url_for(:controller => 'sessions', :action => 'new')
    assert_response :success
  end
  
  test "should rerender for create new without required params" do
    post url_for(:controller => 'sessions', :action => 'create')
    assert_response :success
  end
  
  test "should redirect for create new success" do
    admin = User.new(email: 'hello@world.com', name: 'john doe', password: '12345678abc')
    admin.save
    
    post url_for(:controller => 'sessions', :action => 'create', :params => {session: { email: 'hello@world.com', password: '12345678abc'}})
    assert_response :redirect
  end
  
  test "should destroy" do
    get url_for(:controller => 'sessions', :action => 'destroy')
    assert_response :redirect
  end
end

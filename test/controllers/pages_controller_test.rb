require 'test_helper'

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get about page" do
    get url_for(:controller => 'pages', :action => 'about')
    assert_response :success
  end
end

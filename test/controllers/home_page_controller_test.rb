require 'test_helper'

class HomePageControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get home_page_welcome_url
    assert_response :success
  end

end

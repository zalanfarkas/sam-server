# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

require 'test_helper'

class HomepagesControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get homepages_login_url
    assert_response :success
  end

  test "should get dashboard" do
    get homepages_dashboard_url
    assert_response :success
  end

end

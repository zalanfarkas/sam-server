# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

require 'test_helper'

class PendingPracticalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pending_practical = pending_practicals(:one)
  end

  test "should get new" do
    get new_pending_practical_url
    assert_response :success
  end

  test "should create pending_practical" do
    assert_difference('PendingPractical.count') do
      post pending_practicals_url, params: { pending_practical: { practical_id: @pending_practical.practical_id, raspberry_pi_id: @pending_practical.raspberry_pi_id } }
    end

    assert_redirected_to pending_practical_url(PendingPractical.last)
  end


end

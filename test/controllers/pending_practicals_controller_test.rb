require 'test_helper'

class PendingPracticalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pending_practical = pending_practicals(:one)
  end

  test "should get index" do
    get pending_practicals_url
    assert_response :success
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

  test "should show pending_practical" do
    get pending_practical_url(@pending_practical)
    assert_response :success
  end

  test "should get edit" do
    get edit_pending_practical_url(@pending_practical)
    assert_response :success
  end

  test "should update pending_practical" do
    patch pending_practical_url(@pending_practical), params: { pending_practical: { practical_id: @pending_practical.practical_id, raspberry_pi_id: @pending_practical.raspberry_pi_id } }
    assert_redirected_to pending_practical_url(@pending_practical)
  end

  test "should destroy pending_practical" do
    assert_difference('PendingPractical.count', -1) do
      delete pending_practical_url(@pending_practical)
    end

    assert_redirected_to pending_practicals_url
  end
end

require 'test_helper'

class PracticalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @practical = practicals(:one)
  end

  test "should get index" do
    get practicals_url
    assert_response :success
  end

  test "should get new" do
    get new_practical_url
    assert_response :success
  end

  test "should create practical" do
    assert_difference('Practical.count') do
      post practicals_url, params: { practical: { course_id: @practical.course_id, end_time: @practical.end_time, start_time: @practical.start_time } }
    end

    assert_redirected_to practical_url(Practical.last)
  end

  test "should show practical" do
    get practical_url(@practical)
    assert_response :success
  end

  test "should get edit" do
    get edit_practical_url(@practical)
    assert_response :success
  end

  test "should update practical" do
    patch practical_url(@practical), params: { practical: { course_id: @practical.course_id, end_time: @practical.end_time, start_time: @practical.start_time } }
    assert_redirected_to practical_url(@practical)
  end

  test "should destroy practical" do
    assert_difference('Practical.count', -1) do
      delete practical_url(@practical)
    end

    assert_redirected_to practicals_url
  end
end

require 'test_helper'

class DemonstratorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @demonstrator = demonstrators(:one)
  end

  test "should get index" do
    get demonstrators_url
    assert_response :success
  end

  test "should get new" do
    get new_demonstrator_url
    assert_response :success
  end

  test "should create demonstrator" do
    assert_difference('Demonstrator.count') do
      post demonstrators_url, params: { demonstrator: { practical_id: @demonstrator.practical_id, sam_demonstrator_id: @demonstrator.sam_demonstrator_id } }
    end

    assert_redirected_to demonstrator_url(Demonstrator.last)
  end

  test "should show demonstrator" do
    get demonstrator_url(@demonstrator)
    assert_response :success
  end

  test "should get edit" do
    get edit_demonstrator_url(@demonstrator)
    assert_response :success
  end

  test "should update demonstrator" do
    patch demonstrator_url(@demonstrator), params: { demonstrator: { practical_id: @demonstrator.practical_id, sam_demonstrator_id: @demonstrator.sam_demonstrator_id } }
    assert_redirected_to demonstrator_url(@demonstrator)
  end

  test "should destroy demonstrator" do
    assert_difference('Demonstrator.count', -1) do
      delete demonstrator_url(@demonstrator)
    end

    assert_redirected_to demonstrators_url
  end
end

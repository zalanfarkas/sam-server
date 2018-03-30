require 'test_helper'

class SimpleStaffFeatureAccessTest < ActionDispatch::IntegrationTest
  
  def sign_in(staff)
    post staff_session_path \
      "staff[email]"    => staff.email,
      "staff[password]" => staff.password
  end
  
  setup do
    @staff = Staff.create!(email: 'z1@gmail.com', password: 'password', sam_staff_id: '99999999', first_name: 'Zac', last_name: 'Fay', card_id: '13645246000')
    sign_in @staff
  end
  
 test "staff (without any courses or demontrator duties) can access dashboard" do
    get dashboard_path
    assert_response :success
    assert_select "h3", text: "You do not have access to any of the feature at the moment..."
  end
  
  test "staff (without any courses or demontrator duties) cannot access attendance recording feature: index action" do
    get manual_attendance_recording_index_path
    assert_response :redirect
  end
  
  test "staff (without any courses or demontrator duties) cannot access attendance recording feature: search action" do
    get manual_attendance_recording_search_path
    assert_response :redirect
  end
  
  test "staff (without any courses or demontrator duties) cannot access attendance recording feature: attendance_recording action" do
    post manual_attendance_recording_attendance_recording_path
    assert_response :redirect
  end
  
  test "staff (without any courses or demontrator duties) cannot access attendance recording feature: index action with other path" do
    get remote_path
    assert_response :redirect
  end
  
  test "staff (without any courses or demontrator duties) cannot access managing C6s feature" do
    get manage_c6s_path
    assert_response :redirect
  end
  
  test "staff (without any courses or demontrator duties) cannot access 'remove C6' feature" do
    get remove_c6_path
    assert_response :redirect
  end
  
  test "staff (without any courses or demontrator duties) cannot access 'add demonstrator' feature" do
    get add_demonstrator_path
    assert_response :redirect
  end
  
  test "staff (without any courses or demontrator duties) cannot access 'create demonstrator' feature" do
    post create_demonstrator_path
    assert_response :redirect
  end
  
  test "staff (without any courses or demontrator duties) cannot access 'demonstrator list' feature" do
    get demonstrator_list_path
    assert_response :redirect
  end
  
  test "staff (without any courses or demontrator duties) cannot access 'remote practical initialisation on Raspberry Pi device' feature" do
    get remote_path
    assert_response :redirect
  end
  
  test "staff (without any courses or demontrator duties) cannot access 'delete demonstrator' feature => 'show page'" do
    get delete_demonstrator_path
    assert_response :redirect
  end
  
  test "staff (without any courses or demontrator duties) cannot access 'destroy demonstrator (delete action)' feature" do
    delete destroy_demonstrator_path
    assert_response :redirect
  end
  
  test "staff (without any courses or demontrator duties) cannot access 'practical details' feature" do
    get practical_details_path
    assert_response :redirect
  end
  
  test "staff (without any courses or demontrator duties) cannot access 'attendance statistics' feature" do
    get attendance_statistics_path
    assert_response :redirect
  end
  
  test "staff (without any courses or demontrator duties) cannot access 'attendance history' feature" do
    get attendance_history_path
    assert_response :redirect
  end
  
end

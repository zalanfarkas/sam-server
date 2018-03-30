require 'test_helper'

class SimpleStudentFeatureAccessTest < ActionDispatch::IntegrationTest

  def sign_in(student)
    post student_session_path \
      "student[email]"    => student.email,
      "student[password]" => student.password
  end
  
  setup do
    @student = Student.create!(email: 'z@gmail.com', password: 'password', sam_student_id: '12345000', first_name: 'Zay', last_name: 'Fag', card_id: '1364524000')
    sign_in @student
  end


  test "student (without demontrator duties) can access dashboard" do
    get dashboard_path
    assert_response :success
    assert_select "h3", text: "You do not have access to any of the feature at the moment..."
  end
  
  test "student (without demontrator duties) cannot access attendance recording feature: index action" do
    get manual_attendance_recording_index_path
    assert_response :redirect
  end
  
  test "student (without demontrator duties) cannot access attendance recording feature: search action" do
    get manual_attendance_recording_search_path
    assert_response :redirect
  end
  
  test "student (without demontrator duties) cannot access attendance recording feature: attendance_recording action" do
    post manual_attendance_recording_attendance_recording_path
    assert_response :redirect
  end
  
  test "student (without demontrator duties) cannot access attendance recording feature: index action with other path" do
    get remote_path
    assert_response :redirect
  end
  
  test "student (without demontrator duties) cannot access managing C6s feature" do
    get manage_c6s_path
    assert_response :redirect
  end
  
  test "student (without demontrator duties) cannot access 'remove C6' feature" do
    get remove_c6_path
    assert_response :redirect
  end
  
  test "student (without demontrator duties) cannot access 'add demonstrator' feature" do
    get add_demonstrator_path
    assert_response :redirect
  end
  
  test "student (without demontrator duties) cannot access 'create demonstrator' feature" do
    post create_demonstrator_path
    assert_response :redirect
  end
  
  test "student (without demontrator duties) cannot access 'demonstrator list' feature" do
    get demonstrator_list_path
    assert_response :redirect
  end
  
  test "student (without demontrator duties) cannot access 'remote practical initialisation on Raspberry Pi device' feature" do
    get remote_path
    assert_response :redirect
  end
  
  test "student (without demontrator duties) cannot access 'delete demonstrator' feature => 'show page'" do
    get delete_demonstrator_path
    assert_response :redirect
  end
  
  test "student (without demontrator duties)cannot access 'destroy demonstrator (delete action)' feature" do
    delete destroy_demonstrator_path
    assert_response :redirect
  end
  
  test "student (without demontrator duties) cannot access 'practical details' feature" do
    get practical_details_path
    assert_response :redirect
  end
  
  test "student (without demontrator duties) cannot access 'attendance statistics' feature" do
    get attendance_statistics_path
    assert_response :redirect
  end
  
  test "student (without demontrator duties) cannot access 'attendance history' feature" do
    get attendance_history_path
    assert_response :redirect
  end


end

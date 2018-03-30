require 'test_helper'

class StudentAsDemonstratorFeatureAccessTest < ActionDispatch::IntegrationTest
  def sign_in(student)
    post student_session_path \
      "student[email]"    => student.email,
      "student[password]" => student.password
  end
  
  setup do
    @coordinator = Staff.create!(email: 'z12@gmail.com', password: 'password', sam_staff_id: '88888888', first_name: 'Pato', last_name: 'Banskyaa', card_id: '13645111000')
    robotics = @coordinator.courses.create!(sam_course_id: 'CS3111', course_title: 'Robotics')
    practical = robotics.practicals.create(start_time: DateTime.now, end_time: DateTime.now + 2.hours, location: "Meston 205")
    @student = Student.create!(email: 'z199@gmail.com', password: 'password', sam_student_id: '77777777', first_name: 'Zacuu', last_name: 'Fayuuu', card_id: '136452111000')
    Demonstrator.create(sam_demonstrator_id: @student.sam_student_id, practical_id: practical.id)
    sign_in @student
  end
  
 test "student with demontrator duties can access dashboard" do
    get dashboard_path
    assert_response :success
    assert_select 'div', /Record attendance/
    assert_select 'div', /Start practical/
    
  end
  
  test "student with demontrator duties can access attendance recording feature: index action" do
    get manual_attendance_recording_index_path
    assert_response :success
    assert_select 'p', /Your current practicals:/
  end

  
  test "student with demontrator duties can access attendance recording feature: index action using other path" do
    get remote_path
    assert_response :success
    assert_select 'h1', /Start Practical on Device/
  end
  
  test "student with demontrator duties cannot access managing C6s feature" do
    get manage_c6s_path
    assert_response :redirect
  end
  
  test "student with demontrator duties cannot access 'remove C6' feature" do
    get remove_c6_path
    assert_response :redirect
  end
  
  test "student with demontrator duties cannot access 'add demonstrator' feature" do
    get add_demonstrator_path
    assert_response :redirect
  end
  
  test "student with demontrator duties cannot access 'create demonstrator' feature" do
    post create_demonstrator_path
    assert_response :redirect
  end
  
  test "student with demontrator duties cannot access 'demonstrator list' feature" do
    get demonstrator_list_path
    assert_response :redirect
  end
  
  test "student with demontrator duties can access 'remote practical initialisation on Raspberry Pi device' feature" do
    get remote_path
    assert_response :success
    assert_select 'h1', /Start Practical on Device/
  end
  
  test "student with demontrator duties cannot access 'delete demonstrator' feature => 'show page'" do
    get delete_demonstrator_path
    assert_response :redirect
  end
  
  test "student with demontrator duties cannot access 'destroy demonstrator (delete action)' feature" do
    delete destroy_demonstrator_path
    assert_response :redirect
  end
  
  test "student with demontrator duties cannot access 'practical details' feature" do
    get practical_details_path
    assert_response :redirect
  end
  
  test "student with demontrator duties cannot access 'attendance statistics' feature" do
    get attendance_statistics_path
    assert_response :redirect
  end
  
  test "student with demontrator duties cannot access 'attendance history' feature" do
    get attendance_history_path
    assert_response :redirect
  end

end

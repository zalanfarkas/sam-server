require 'test_helper'

class CourseCoordinatorFeatureAccessTest < ActionDispatch::IntegrationTest
  
  def sign_in(staff)
    post staff_session_path \
      "staff[email]"    => staff.email,
      "staff[password]" => staff.password
  end
  
  setup do
    @coordinator = Staff.create!(email: 'z12@gmail.com', password: 'password', sam_staff_id: '88888888', first_name: 'Pato', last_name: 'Banskyaa', card_id: '13645111000')
    robotics = @coordinator.courses.create!(sam_course_id: 'CS3111', course_title: 'Robotics')
    practical = robotics.practicals.create(start_time: DateTime.now, end_time: DateTime.now + 2.hours, location: "Meston 205")
    sign_in @coordinator
  end
  
 test "course coordinator can access dashboard" do
    get dashboard_path
    assert_response :success
    assert_select 'div', /Record attendance/
    assert_select 'div', /Start practical/
    
  end
  
  test "course coordinator can access attendance recording feature: index action" do
    get manual_attendance_recording_index_path
    assert_response :success
    assert_select 'p', /Your current practicals:/
  end

  
  test "course coordinator can access attendance recording feature: index action using other path" do
    get remote_path
    assert_response :success
    assert_select 'h1', /Start Practical on Device/
  end
  
  test "course coordinator can access managing C6s feature" do
    get manage_c6s_path
    assert_response :success
  end
  
  test "course coordinator can access 'add demonstrator' feature" do
    get add_demonstrator_path
    assert_response :success
  end
  
  
  test "course coordinator can access 'demonstrator list' feature" do
    get demonstrator_list_path
    assert_response :success
  end
  
  test "course coordinator can access 'remote practical initialisation on Raspberry Pi device' feature" do
    get remote_path
    assert_response :success
    assert_select 'h1', /Start Practical on Device/
  end
  
  test "course coordinator can access 'delete demonstrator' feature => 'show page'" do
    get delete_demonstrator_path
    assert_response :success
  end
  
  test "course coordinator can access 'attendance statistics' feature" do
    get attendance_statistics_path
    assert_response :success
  end
  
  test "course coordinator can access 'attendance history' feature" do
    get attendance_history_path
    assert_response :success
  end

end

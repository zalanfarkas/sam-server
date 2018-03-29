# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest
#include Devise::Test::ControllerHelpers

  #def setup
    #@request.env["devise.mapping"] = Devise.mappings[:admin]
    #sign_in staffs(:one)
  #end
  
  def sign_in(staff)
    post staff_session_path \
      "staff[email]"    => staff.email,
      "staff[password]" => staff.password
  end

  def sign_in_for(subject)
    @user =Staff.create(email: "#{rand(50000)}@example.com", password: 'password')
    sign_in @user
    subject.update_attribute(:user_id, @user.id)
  end
  
  

  
  
  test "unauthenticated user cannot access dashboard" do
    get dashboard_path
    assert_response :redirect
  end
  
  test "unauthenticated user cannot access attendance recording feature: index action" do
    get manual_attendance_recording_index_path
    assert_response :redirect
  end
  
  test "unauthenticated user cannot access attendance recording feature: search action" do
    get manual_attendance_recording_search_path
    assert_response :redirect
  end
  
  test "unauthenticated user cannot access attendance recording feature: attendance_recording action" do
    post manual_attendance_recording_attendance_recording_path
    assert_response :redirect
  end
  
  test "unauthenticated user cannot access attendance recording feature: index action with other path" do
    get remote_path
    assert_response :redirect
  end
  
  test "unauthenticated user cannot access managing C6s feature" do
    get manage_c6s_path
    assert_response :redirect
  end
  
  test "unauthenticated user cannot access 'remove C6' feature" do
    get remove_c6_path
    assert_response :redirect
  end
  
  test "unauthenticated user cannot access 'add demonstrator' feature" do
    get add_demonstrator_path
    assert_response :redirect
  end
  
  test "unauthenticated user cannot access 'create demonstrator' feature" do
    post create_demonstrator_path
    assert_response :redirect
  end
  
  test "unauthenticated user cannot access 'demonstrator list' feature" do
    get demonstrator_list_path
    assert_response :redirect
  end
  
  test "unauthenticated user cannot access 'remote practical initialisation on Raspberry Pi device' feature" do
    get remote_path
    assert_response :redirect
  end
  
  test "unauthenticated user cannot access 'delete demonstrator' feature => 'show page'" do
    get delete_demonstrator_path
    assert_response :redirect
  end
  
  test "unauthenticated user cannot access 'destroy demonstrator (delete action)' feature" do
    delete destroy_demonstrator_path
    assert_response :redirect
  end
  
  test "unauthenticated user cannot access 'practical details' feature" do
    get practical_details_path
    assert_response :redirect
  end
  
  test "unauthenticated user cannot access 'attendance statistics' feature" do
    get attendance_statistics_path
    assert_response :redirect
  end
  
  test "unauthenticated user cannot access 'attendance history' feature" do
    get attendance_history_path
    assert_response :redirect
  end
  
  test "authenticated user cannot access 'attendance history' feature" do
    @coordinator = Staff.create!(email: 'z1@gmail.com', password: 'password', sam_staff_id: '99999999', first_name: 'Zac', last_name: 'Fay', card_id: '13645246000')
    @coordinator.courses.create!(sam_course_id: 'CS3028', course_title: 'Software Engineering')
    sign_in @coordinator
    #@coordinator.update_attribute(:id, @coordinator.id)
    get dashboard_path
    assert_response :success
    get demonstrator_list_path
    assert_response :success
    #get attendance_history_path
    #assert_response :redirect
  end
end

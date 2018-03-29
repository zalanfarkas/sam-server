# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "the truth" do
    assert true
  end
  
  test "get course id is accessible" do
    post api_get_course_path, params: {}
    assert_response :success
  end
  
  test "get course id without type should give an error" do
    post api_get_course_path, params: {} 
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal json_response["error"], "NO DATA RECEIVED"
    assert_equal json_response["success"], false
  end
  
  test "get course id with invalid data should tell that user is not demonstrator" do
    post api_get_course_path, params: {'type' => 'nfc', 'data' => '0'} 
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal json_response["error"], "YOU ARE NOT                             A DEMONSTRATOR"
    assert_equal json_response["success"], false
  end
  
  test "get course id with demonstrator who doesn't have practical" do
    post api_get_course_path, params: {'type' => 'nfc', 'data' => '13645246150'} 
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal json_response["error"], "NO CURRENT                              PRACTICALS"
    assert_equal json_response["success"], false
  end
  
  test "should not allow to record attendance without required parameters" do
    
    post api_record_attendance_path, params: {} 
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal json_response["success"], false
    assert_equal json_response["error"], "MISSING DATA"
    
  end
  
  test "should not allow to record attendance for course which doesn't exists" do
    
    post api_record_attendance_path, params: {'course_id' => '-1', 'type' => 'nfc', 'data' => '13645246150'} 
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal json_response["success"], false
    assert_equal json_response["error"], "COURSE NOT FOUND"
    
  end
  
  test "should not allow to record attendance for student with wrong nfc data" do
    
    post api_record_attendance_path, params: {'course_id' => 'CS3001', 'type' => 'nfc', 'data' => '-1'} 
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal json_response["success"], false
    assert_equal json_response["error"], "STUDENT                                 NOT FOUND"
    
  end
  
  test "should not allow to record attendance for student with wrong fingeprint data" do
    
    post api_record_attendance_path, params: {'course_id' => 'CS3001', 'type' => 'fingerprint', 'data' => '-1'} 
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal json_response["success"], false
    assert_equal json_response["error"], "STUDENT                                 NOT FOUND"
    
  end
  
  test "should not allow to record attendance with type that doesn't exist" do
    
    post api_record_attendance_path, params: {'course_id' => 'CS3001', 'type' => 'random', 'data' => '11111111'} 
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal json_response["success"], false
    assert_equal json_response["error"], "TYPE NOT FOUND"
    
  end
  
  
  test "should not allow to record attendance if student is not enrolled" do
    
    post api_record_attendance_path, params: {'course_id' => 'CS3001', 'type' => 'nfc', 'data' => '00000000'} 
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal json_response["success"], false
    assert_equal json_response["error"], "NOT ENROLLED                            FOR CS3001"
    
  end
  
  test "should not allow to record attendance if practical is not started" do
    
    post api_record_attendance_path, params: {'course_id' => 'CS3001', 'type' => 'nfc', 'data' => '13645246150'} 
    assert_response :success
    json_response = JSON.parse(@response.body)
    assert_equal json_response["success"], false
    assert_equal json_response["error"], "NO PRACTICALS                           AT THE MOMENT"
    
  end
  
end

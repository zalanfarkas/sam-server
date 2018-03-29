# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

require 'test_helper'

class ManualAttendanceRecordingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get manual_attendance_recording_index_url
    assert_response :success
  end

end

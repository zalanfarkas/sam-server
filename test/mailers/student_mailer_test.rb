# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

require 'test_helper'

class StudentMailerTest < ActionMailer::TestCase
  test "absense_notification" do
    user = Student.first
    course = Course.first
    mail = StudentMailer.absense_notification(user, course)
    assert_equal "Absense Form", mail.subject
    assert_match "Hi", mail.body.encoded
  end

end

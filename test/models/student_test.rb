# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  def setup
    @student = Student.new(email: 'zac1@example.com', password: 'password', sam_student_id: '12345670', first_name: 'Dave', last_name: 'Fay', card_id: '13645246159')
    @student2 = Student.new()
  end

  test "should be valid" do
    assert @student.valid?
  end
  
  test "should fail during validation" do
    assert_not @student2.valid?
  end
  
  test "email addresses should be unique" do
    duplicate_user = @student.dup
    duplicate_user.email = @student.email.upcase
    @student.save
    assert_not duplicate_user.valid?
  end
  
  test "sam student ID should be unique" do
    duplicate_user = @student.dup
    @student.save
    assert_not duplicate_user.valid?
  end

end

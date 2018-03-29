# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

require 'test_helper'

class StaffTest < ActiveSupport::TestCase
  def setup
    @staff = Staff.new(email: 'zac1@example.com', password: 'password', sam_staff_id: '12345670', first_name: 'Dave', last_name: 'Fay', card_id: '13645246159')
    @staff2 = Staff.new()
  end

  test "should be valid" do
    assert @staff.valid?
  end
  
  test "should fail during validation" do
    assert_not @staff2.valid?
  end
  
  test "email addresses should be unique" do
    duplicate_user = @staff.dup
    duplicate_user.email = @staff.email.upcase
    @staff.save
    assert_not duplicate_user.valid?
  end
  
  test "sam staff ID should be unique" do
    duplicate_user = @staff.dup
    @staff.save
    assert_not duplicate_user.valid?
  end

end

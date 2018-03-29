# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

require 'test_helper'

class PracticalTest < ActiveSupport::TestCase
  def setup
    @practical = practicals(:one)
    @practical2 = Practical.new()
  end

  test "should be valid" do
    assert @practical.valid?
  end
  
  test "should fail during validation" do
    assert_not @practical2.valid?
  end
  
  test "missing end_time" do
    @p = Practical.new(start_time: DateTime.now-1.hour)
    assert_not @p.valid?
  end
  
  test "missing start_time" do
    @p = Practical.new(end_time: DateTime.now-1.hour)
    assert_not @p.valid?
  end
  
end

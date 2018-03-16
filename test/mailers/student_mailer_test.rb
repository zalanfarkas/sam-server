require 'test_helper'

class StudentMailerTest < ActionMailer::TestCase
  test "absense_notification" do
    mail = StudentMailer.absense_notification
    assert_equal "Absense Form", mail.subject
    assert_match "Hi", mail.body.encoded
  end

end

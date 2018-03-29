# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# Preview all emails at http://localhost:3000/rails/mailers/student_mailer
class StudentMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/student_mailer/absense_notification
  def absense_notification
    user = Student.first
    course = Course.first
    StudentMailer.absense_notification(user, course)
  end

end

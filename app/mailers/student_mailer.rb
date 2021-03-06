# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# mailer class used to send email notification to students
class StudentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.absense_notification.subject
  #
  def absense_notification(user, course)
    @user = user
    @course = course
    mail to: user.email, subject: "Absense Form"
  end
end

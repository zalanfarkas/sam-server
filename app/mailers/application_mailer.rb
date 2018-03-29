# Copyright (c) 2018 Team Foxtrot
# Licensed under MIT License

# superclass of student mailer used to send email notification to students
class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@abdn-sam.herokuapp.com'
  layout 'mailer'
end

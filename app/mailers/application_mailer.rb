class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@abdn-sam.herokuapp.com'
  layout 'mailer'
end

class MessageMailer < ActionMailer::Base
  default to: current_user.email
  def notifcation_email(name, email)
    @name = name
    @email = email
    mail(from: email, subject: 'Message Alert')
  end
end
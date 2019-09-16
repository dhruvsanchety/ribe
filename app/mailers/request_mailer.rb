class RequestMailer < ActionMailer::Base
  default to: current_user.email
  def request_email(name, email)
    @name = name
    @email = email
    mail(from: email, subject: 'Request Alert')
  end
end
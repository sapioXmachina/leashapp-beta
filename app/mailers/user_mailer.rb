class UserMailer < ActionMailer::Base
  default :from => ENV["USER_MAILER2"]

  def registration_confirmation(user)
    @user = user

    mail(:to => "#{user.name} <#{user.email}>", :subject => ENV["USER_MAILER1"])
  end
end

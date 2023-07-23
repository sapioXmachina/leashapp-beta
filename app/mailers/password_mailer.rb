class PasswordMailer < ApplicationMailer
  default :from => ENV["PASSWORD_MAILER2"]
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.reset.subject
  #
  def reset
    @token = params[:user].signed_id(purpose: ENV["PASSWORD_MAILER1"], expires_in: 15.minutes)

    mail to: params[:user].email
  end
end

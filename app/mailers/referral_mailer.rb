class ReferralMailer < ApplicationMailer
  default :from => ENV["REFERRAL_MAILER"]
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.reset.subject
  #
  def referral
    @referral_key = params[:account].referral_key

    mail to: params[:client].email
  end
end

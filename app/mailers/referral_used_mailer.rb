class ReferralUsedMailer < ActionMailer::Base
  default :from => ENV["REF_USED_MAILER2"]

  def referral_used(user)
    @user = user

    mail(:to => "#{client.name} <#{client.email}>", :subject => ENV["REF_USED_MAILER1"])
  end
  #
  # def registration_confirmation(user)
  #   @user = user
  #   mail(:to => "#{user.name} <#{user.email}>", :subject => "Woof! Join us on #LeashApp.")
  # end
end

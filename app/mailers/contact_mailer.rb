class ContactMailer < ApplicationMailer
  default :from => ENV["CONTACT_MAILER2"]

  def contact(message)
    @message = message

    mail(to: :email, subject: ENV["CONTACT_MAILER1"])
  end
end

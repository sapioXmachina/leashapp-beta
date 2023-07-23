class CourierMailer < ActionMailer::Base
  default :from => ENV["COURIER_MAILER2"]

  def mail_method(data, email)
    @email = email
    @referral_key = data
    @address_to = '<' + email + '>'
    @client = Client.find(email)
    @address = @client.name + ' <' + @client.email + '>'
    @referral_code = @referral_key

    mail(to: @address, subject: ENV["COURIER_MAILER1"])
  end
end

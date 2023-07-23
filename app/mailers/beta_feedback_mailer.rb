class BetaFeedbackMailer < ApplicationMailer
  default :from => ENV["BETA_FEEDBACK_MAILER"],
          :bcc => ENV["BETA_FEEDBACK_MAILER"],
          :reply_to => @sender

  def beta_feedback(account, email, name, client, subject, message)
    @account = account
    @email = email
    @name = name
    @client = client
    @sender = name + ' <' + email + '>'
    @subject = subject
    @message = message

    mail(to: @sender, subject: @subject)
  end
end

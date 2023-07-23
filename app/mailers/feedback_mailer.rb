class FeedbackMailer < ApplicationMailer
  default :from => ENV["FEEDBACK_MAILER"],
          :bcc => ENV["FEEDBACK_MAILER"],
          :reply_to => @sender

  def send_feedback(email, name, subject, message)
    @name = name
    @email = email
    @sender = name + ' <' + email + '>'
    @subject = subject
    @message = message
    # reply_to  @email

    mail(to: @sender, subject: @subject)
  end
end

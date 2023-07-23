class FeedbackController < ApplicationController
  def index
  end

  def new
    @contact = Contact.new
    @account = Account.find_by(id: Current.user.account_id)
  end

  def create
    @account = Account.find_by(id: Current.user.account_id)
    @client = Client.find_by(email: params[:email])
    email = params[:email]

    if Current.user.logged_in? && @contact.save
      FeedbackMailer.send_feedback(@contact).deliver
      flash[:success] = "Feedback submitted successfully! Thank you so much -- we will be in touch soon."
      redirect_to :feedback
    else
      flash[:danger] = "Woof! Something's not right. Please try again."
      redirect_to :feedback
    end
  end

  def path
    email = params[:email]
    name = params[:name]
    subject = params[:subject]
    message = params[:message]

    FeedbackMailer.send_feedback(email, name, subject, message).deliver
    flash[:success] = "Feedback submitted successfully! Thank you so much -- we will be in touch soon."
    redirect_to feedback_path
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :subject, :message)
  end
end

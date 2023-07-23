class BetaFeedbackController < ApplicationController
  before_action :require_user_loggedin!

  def index
    @beta = Beta.new
  end

  def email=(email)
    super(email.downcase.strip)
  end

  def new
    # @beta = Beta.new
    @user = User.find_by(id: Current.user.id)
    @account = Account.find_by(id: Current.user.account_id)
  end

  # def create
  #   @account = Account.find(Current.user.account_id)
  #   @client = Client.find_by(client_id: params[:client_id])
  #   email = params[:email]

  #   if Current.user.logged_in? && @contact.save
  #     BetaFeedbackMailer.beta_feedback(@contact).deliver
  #     flash[:success] = "Beta Feedback submitted successfully! Thank you so much -- we will be in touch soon."
  #     redirect_to :feedback
  #   else
  #     flash[:danger] = "Woof, something went wrong!"
  #     redirect_to :feedback
  #   end
  # end

  def path
    account = params[:account]
    email = params[:email]
    name = params[:name]
    client = params[:client]
    subject = params[:subject]
    message = params[:message]

    BetaFeedbackMailer.beta_feedback(account, email, name, client, subject, message).deliver
    flash[:success] = "Beta Feedback submitted successfully! Thank you so much -- we will be in touch soon."
    redirect_to beta_feedback_path
  end

end

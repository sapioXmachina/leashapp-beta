class ReferralsController < ApplicationController
  def index
  end

  def new
    @user = User.new
    @account = Account.find_by(referral_key: params[:referral_key])
  end

  def create
    @account = Account.find_by(referral_key: params[:referral_key])
    @client = Client.find_by(email: params[:email])

    if @account.present? && @account.authenticate(params[:referral_key])
      # Send email
      ReferralMailer.with(client: @client, account: @account).referral.deliver_later
      # deliver_now will slow down rails app until finished sending
    end
    flash[:success] = "Congrats! Your client will receive their referral sign-up link momentarily."
    redirect_to dashboard_path
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    flash[:alert] = "Woof! Something's not right. Please try again."
    redirect_to root_path
  end

  def update
    @user = User.find_signed!(params[:token], purpose: "password_reset")
    if @user.update(referral_params)
      flash[:success] = "Your password was changed successfully. Please sign in again to continue."
      redirect_to log_in_path
    else
      render :edit
    end
  end

  private

  def referral_params
    params.require(:client).permit(:id, :account_name, :email, :referral_key)
    params.require(:account).permit(:id, :account_name, :referral_key)
    params.require(:user).permit(:name, :email, :account, :role, :account_id, :password, :password_confirmation, :referral_key, :email_confirmed, :confirm_token)
  end
end

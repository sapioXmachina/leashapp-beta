class ReferralCodesController < ApplicationController
  def new
  rescue ActiveSupport::RecordNotUnique
    redirect_to log_in_path
    flash[:alert] = "Woof! Something's not right. Please contact your Account Admin for more information."
  end

  def create
    @client = Client.find_by(email: params[:email])
    @account = Account.find_by(referral_key: params[:referral_key])

    if @user.present?
      # Send email
      ReferralCodesMailer.with(client: @client).reset.deliver_now
      # deliver_now will slow down rails app until finished sending
    end
    flash[:alert] = "If an account with that email was found, you will receive an email with a link to be able to access your account."
    redirect_to referrals_path
  end

  def create_referral
    @client = Client.find_by(email: params[:email])
    @account = Account.find_by(referral_key: params[:referral_key])

    if @user.present?
      # Send email
      ReferralCodesMailer.with(client: @client).reset.deliver_now
      # deliver_now will slow down rails app until finished sending
    end
    flash[:success] = "Successfully sent Referral Code email!"
    redirect_to manage_clients_path
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    flash[:alert] = "Woof! Something's not right. Please try again."
    redirect_to root_path
  end

  def update
    @user = User.find_signed!(params[:token], purpose: "password_reset")
    if @user.update(password_params)
      flash[:success] = "Your password was changed successfully. Please sign in again to continue."
      redirect_to log_in_path
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end

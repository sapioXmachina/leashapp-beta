class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      # Send email
      PasswordMailer.with(user: @user).reset.deliver_now
      # deliver_now will slow down rails app until finished sending
    end
    flash[:alert] = "If an account with that email was found, you will receive an email with a link to reset your password."
    redirect_to root_path
  end

  def create_user
    @user = User.find(params[:id])

    if @user.present?
      # Send email
      PasswordMailer.with(user: @user).reset.deliver_now
      # deliver_now will slow down rails app until finished sending
    end
    flash[:successful] = "Successfully sent a new Reset Password email!"
    redirect_to manage_users_path
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
      redirect_to :log_in
    else
      render :edit
    end
  end

  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end

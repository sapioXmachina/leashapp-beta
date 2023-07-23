class PasswordsController < ApplicationController
  before_action :require_user_loggedin!
  
  def edit
  end
  
  def update
    if Current.user.update(password_params)
      flash[:success] = "Password successfully updated!"
      redirect_to edit_password_path
    else
      render :edit
    end
  end
  
  private
  
  def password_params
    params.require(:user).permit(:id, :password, :password_confirmation)
  end
end

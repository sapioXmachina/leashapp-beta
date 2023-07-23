class SessionsController < ApplicationController
  def new
    if Current.user.nil?
      render :new
    else
      flash[:success] = 'Welcome back ' + Current.user.name + '! Logged in successfully as ' + Current.user.role + '.'
      redirect_to dashboard_path
    end
  end

  def email=(email)
    super(email.downcase.strip)
  end

  def create
    user = User.find_by(email: params[:email]&.downcase)
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'Welcome back ' + user.name + '! Logged in successfully as ' + user.role + '.'
      redirect_to dashboard_path(User)
    elsif !user.present?
      flash[:alert] = "Woof! Please check you email or password, and try again."
      redirect_to log_in_path
    else
      flash[:alert] = "Woof! Please check you email or password, and try again."
      redirect_to log_in_path
    end
  end

  # def success_msg
  #   @user = User.find_by(email: params[:email]&.downcase)
  # end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out successfully."
    redirect_to root_path
  end
end

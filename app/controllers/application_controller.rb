class ApplicationController < ActionController::Base
  before_action :set_current_user

  # rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

  # def handle_parameter_missing(exception)
  #   render json: { error: exception.message }, status: :bad_request
  # end

  def set_current_user
    if session[:user_id]
      Current.user = User.find_by(id: session[:user_id])
    end
  end

  def require_user_loggedin!
    if Current.user.nil?
      redirect_to root_path
      flash[:alert] = "You are not logged in."
    end
  end

  def index
    if session[:user_id]
      @user = User.find_by(session[:user_id])
    end
  end
end

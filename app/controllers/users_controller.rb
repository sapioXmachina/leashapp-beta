require "csv"

class UsersController < ApplicationController
  before_action :require_user_loggedin!, only: [:show]

  def admin
    Current.user.role == "admin"
  end

  def index
    def confirm_email
      user = User.find_by_confirm_token(params[:id])
      if user
        user.email_activate
        flash[:success] = "AAHHWOOOOOOOO! Welcome to #LeashApp -- your email has been confirmed. Please sign in to continue."
        redirect_to root_path
      else
        flash[:danger] = "Woof! Something's not right. Please try again."
        redirect_to root_path
      end
    end

    if Current.user.nil?
       flash[:alert] = "You are not logged in."
       redirect_to root_path
    elsif Current.user.admin?
      @users_all = User.all&.order(:name)
    elsif Current.user.user?
      @users_all = User.where("account_id = ? AND id != ? AND name != ?", Current.user.account_id, Current.user.id, "New Client User")&.order(:name)
    else
      flash[:info] = "Update your account details here."
      redirect_to edit_password_path(User)
    end
    #
    # if Current.user.admin?
    #   @users_all = User.all&.order(:name)
    # elsif Current.user.user?
    #   @userss_all = User.where("account_id = ? AND id != ? AND name != ?", Current.user.account_id, Current.user.id, "New Client User")&.order(:name)
    # else
    #   redirect_to edit_password_path(User), notice: "Update your account details here."
    # end
  end

  def new
    @user = User.new
    @account = Account.find_by(referral_key: "iacdYTKoGT9w")
    render :new
  end

  def new_referral
    @user = User.new
    @account = Account.find_by(referral_key: params[:referral_key])
    render :new_referral
    flash.now[:success] = "Referral Code accepted!"
  end

  def new_create
    require_user_loggedin!
    @user = User.new
    @account = Account.find_by(referral_key: params[:referral_key])
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "AAHHWOOOOOOOO! Welcome to #LeashApp -- your email has been confirmed. Please sign in to continue."
      redirect_to log_in_path
    else
      flash[:danger] = "Woof! Something's not right. Please try again."
      redirect_to root_url
    end
  end

  def referral_email
    user = User.find_by_referral_key(params[:id])
    if user
      user.referral_activate
      flash[:success] = "AAHHWOOOOOOOO! Welcome to #LeashApp -- your email has been confirmed. Please sign in to continue."
      redirect_to log_in_path
    else
      flash[:danger] = "Woof! Something's not right. Please try again."
      redirect_to new_user_path
    end
  end

  def create
    @user = User.new(user_params)

    if Current.user.nil? && @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:alert] = "Welcome to #LeashApp! Please confirm your registration in order to start using your #LeashApp account. You should receive a confirmation email in a few minutes."
      redirect_to root_url
    elsif @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = "User account successfully created! Verification email sent successfully."
      redirect_to user_path(@user)
    else
      flash[:danger] = "Woof! Something's not right. Please try again."
      render :new_create
    end
  end

  def create_referral
    @account = Account.find_by(referral_key: params[:referral_key])
    @user = User.new(user_params)

    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      flash[:alert] = "Please confirm your registration in order to start using your #LeashApp account. You should receive a confirmation email in a few minutes."
      redirect_to root_url
    elsif @user.save
      session[:user_id] = @user.id
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = "XXXXXX User account successfully created! XXXXX"
      redirect_to manage_users_path
      ### ^-- IS THIS NECESSARY??? --^ ###
    else
      flash[:danger] = "Woof! Something's not right. Please try again."
      redirect_to :new_referral
    end
  end

  def create_user_referral
    @account = Account.find_by(referral_key: "iacdYTKoGT9w")
    @user = User.new(user_params)

    begin
      if Current.user.nil? && @user.save
        UserMailer.registration_confirmation(@user).deliver
        flash[:alert] = "Welcome to #LeashApp! Please confirm your registration in order to start using your #LeashApp account. You should receive a confirmation email in a few minutes."
        redirect_to root_url
      else
        flash[:danger] = "Woof! Something's not right. Please check that your referral code is entered correctly."
        redirect_to new_user_path
      end
    rescue ActiveRecord::RecordNotUnique => @user.email
      flash[:alert] = "Woof! Please check your email address and referral code, and try again."
      redirect_to new_user_path
      return
    end


  #   if @user.save
  #     UserMailer.registration_confirmation(@user).deliver
  #     redirect_to root_url
  #     flash[:alert] = "Please confirm your registration in order to start using your #LeashApp account. You should receive a confirmation email in a few minutes."
  #   elsif @user.save
  #     session[:user_id] = @user.id
  #     redirect_to manage_users_path
  #     flash[:success] = "User account successfully created!"
  #     ### ^-- IS THIS NECESSARY??? --^ ###
  #   elsif
  #     render :new
  #     flash[:alert] = "Woof, something went wrong! Please check that your referral code is entered correctly."
  #   end
  end

  # # Sign Up w/Autologin
  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     redirect_to root_url, notice: "Your account was successfully created!"
  #   else
  #     if @user.save
  #       session[:user_id] = @user.id
  #       redirect_to manage_users_path, notice: "User account successfully created!"
  #     end
  #   render :new
  #   end
  # end

  def show
    require_user_loggedin!
    @user = User.find(params[:id])
    # @clients = @user.clients
    @pets = @user.pets
    @walks = @user.walks
    render :show
  end

  def edit
    require_user_loggedin!
    @user = User.find(params[:id])
    render :edit
  end

  def edit_user
    require_user_loggedin!
  end

  def update
    # raise params.inspect
    # puts params.inspect
    require_user_loggedin!
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "User successfully updated!"
      redirect_to user_path(@user)
    else
      render :edit
      flash.now[:alert] = "Woof! Something's not right. Please try again."
    end
  end

  def update_user
    # raise params.inspect
    # puts params.inspect
    require_user_loggedin!
    if Current.user.update(user_params)
      flash[:success] = "Profile successfully updated!"
      redirect_to user_edit_path
    else
      render :edit
    end
  end
  
  def search
      @users = User.where('name LIKE ?', "%#{params[:query]}%")
  end
  
  def sort
      @users = User.order(params[:sort_by])
  end

  def export
    require_user_loggedin!
    if Current.user.user?
      @users_all = User.where("account_id = ? AND id != ? AND name != ?", Current.user.account_id, Current.user.id, "New Client User")&.where(account_id: Pet.where("name != ?", "New Pet"))
    else
      @users_all = User.all
    end

    users = User.includes(:account_name, :name, :email, :role, :account_id, :updated_date, :created_at).order("#{params[:name]} asc")

    respond_to do |format|
      format.csv do
        response.headers["Content-Type"] = "text/csv"
        response.headers["Content-Disposition"] = "attachment; filename=users.csv"
      end
    end
  end

  def destroy
    require_user_loggedin!
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :account_name, :account_id, :role, :password, :password_confirmation, :email_confirmed, :confirm_token, :referral_key)

    # case current_user.role
    # when :admin
    #   params.require(:user).permit(:name, :email, :account, :role, :account_id, :password, :password_confirmation, :email_confirmed, :confirm_token)
    # when :user
    #   params.require(:user).permit(:name, :email, :account, :role, :account_id, :password, :password_confirmation, :email_confirmed, :confirm_token)
    # when :client
    #   params.require(:user).permit(:name, :email, :account, :role, :account_id, :password, :password_confirmation, :email_confirmed, :confirm_token)
    # end
  end

  def account_params
    params.require(:user).permit(:account_id, :referral_key, :name, :email, :password, :password_confirmation, :query, :sort_by, account_ids: [])
  end

  def referral_params
    params.require(:account).permit(:id, :referral_key, :account_name)
  end
end

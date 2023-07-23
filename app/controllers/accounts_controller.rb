# User Managements Duplicate
require "csv"

class AccountsController < ApplicationController
  before_action :require_user_loggedin!, except: [:new, :create_new]

  include ActiveStorage::SetCurrent

  def index
    if Current.user.nil?
      flash[:alert] = "You are not logged in."
      redirect_to root_path
    elsif Current.user.admin?
      @accounts_all = Account.all&.order(:account_name)
    elsif Current.user.user?
      @accounts_all = Account.where("account_id = ? AND name != ?", Current.user.account_id, "New Account")&.order(:account_name)
    else
      flash[:danger] = "You do not have permission to do this. Please contact your Account Admin."
      redirect_to root_path
    end
    #
    # if Current.user.admin?
    #   @accounts_all = Account.all&.order(:name)
    # elsif Current.user.user?
    #   @userss_all = Account.where("account_id = ? AND id != ? AND name != ?", Current.user.account_id, Current.user.id, "New Client User")&.order(:name)
    # else
    #   redirect_to edit_password_path(User), notice: "Update your account details here."
    # end
  end

  def new
    @account = Account.new
  end

  def create_new
    @account = Account.new(account_params)
    if @account.save
      flash[:alert] = "Thank you for your interest! We will reach out to you soon!"
      redirect_to :root
    else
      render :new
      flash.now[:alert] = "Woof! Something's not right. Please try again."
    end
  end

  def new_create
    require_user_loggedin!
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      flash[:success] = "Account successfully created! You can now add users who will access the new account."
      redirect_to account_path(@account)
    else
      render :new_create
      flash.now[:alert] = "Woof! Something's not right. Please try again."
    end
  end

  # def confirm_email
  #   user = Account.find_by_confirm_token(params[:id])
  #   if user
  #     user.email_activate
  #     flash[:notice] = "AAHHWOOOOOOOO! Welcome to #LeashApp -- your email has been confirmed. Please sign in to continue."
  #     redirect_to log_in_path
  #   else
  #     flash[:error] = "Sorry. User account does not exist."
  #     redirect_to root_url
  #   end
  # end

  # # Sign Up w/Autologin
  # def create
  #   @account = Account.new(user_params)
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
    @account = Account.find(params[:id])
    @users = @account.users
    @clients = @account.clients
    @pets = @account.pets
    @walks = @account.walks
    render :show
  end

  def edit
    require_user_loggedin!
    @account = Account.find(params[:id])
    render :edit
  end

  # def edit_user
  #   require_user_loggedin!
  #   render :edit_user
  # end

  def update
    # raise params.inspect
    # puts params.inspect
    require_user_loggedin!
    @account = Account.find(params[:id])
    if @account.update(account_params)
      flash[:success] = "Account successfully updated!"
      redirect_to account_path(@account)
    else
      render :edit
      flash.now[:danger] = "Woof! Something's not right. Please try again."
    end
  end

  # def update_user
  #   # raise params.inspect
  #   # puts params.inspect
  #     require_user_loggedin!
  #     if Current.user.update(user_params)
  #       redirect_to user_edit_path, notice: "Account successfully updated!"
  #     else
  #       render :edit
  #     end
  # end

  def export
    if Current.user.user?
      @accounts_all = Account.where("account_id = ? AND name != ?", Current.user.account_id, "New Account")
    else
      @accounts_all = Account.all
    end

    accounts = Account.includes(:id, :account_name, :referral_key, :account_logo, :account_description, :account_rates, :account_admin, :updated_date, :created_at).order("#{params[:account_name]} asc")

    respond_to do |format|
      format.csv do
        response.headers["Content-Type"] = "text/csv"
        response.headers["Content-Disposition"] = "attachment; filename=accounts.csv"
      end
    end
  end

  def destroy
    require_user_loggedin!
  end

  private

  def account_params
    params.require(:account).permit(:id, :account_name, :referral_key, :account_logo, :account_description, :account_rates, :account_admin, user_ids: [])
  end
end

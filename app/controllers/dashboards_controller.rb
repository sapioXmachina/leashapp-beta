class DashboardsController < ApplicationController
  before_action :require_user_loggedin!

  def index
    # @youngest = Pet.where(client_id: Current.user.client.id)&.order('age asc').first
    # @eldest = Pet.where(client_id: Current.user.client.id)&.order('age desc').first
    
    if Current.user.role  == "admin"
      @accounts = Account.all&.order(:account_name)
      @users = User.all&.order(:name)
      @clients = Client.all&.order(:name)
      @pets = Pet.all&.order(:name)
      @walks = Walk.all&.order(:startdatetime)
      
    elsif Current.user.role == "user"
      @accounts = Account.where(account_id: Current.user.account_id)&.order(:account_name)
      @users = User.where(account_id: Current.user.account_id)&.order(:name)
      @clients = Client.where(account_id: Current.user.account_id)&.order(:name)
      @pets = Pet.where("client_id = ? AND name != ?", Client.where("account_id = ?", Current.user.account_id), "New Pet")&.order(:name)
      @walks = Walk.where("client_id = ? AND pet_id = ?", Client.where("account_id = ? AND name != ?", Current.user.account_id, "New Client"), Pet.where("name != ?", "New Pet"))&.order(:startdatetime)
     
    elsif Current.user.role == "client"
      @accounts = Account.where(account_id: Current.user.account_id)&.order(:account_name)
      @users = Current.user
      @clients = Client.where(email: Current.user.email)&.order(:name)
        @pets = Pet.where("client_id = ? AND name != ?", Client.where("email = ?", Current.user.email), "New Pet")&.order(:name)
      @walks = Walk.where("client_id = ? AND pet_id = ?", Client.where("email = ?", Current.user.email), Pet.where("name != ?", "New Pet"))&.order(:startdatetime)
    
    else
      flash[:notice] = "You are not logged in."
      redirect_to root_path
    end
  end
end

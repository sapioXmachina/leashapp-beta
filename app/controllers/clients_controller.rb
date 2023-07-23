require "csv"

class ClientsController < ApplicationController
  before_action :require_user_loggedin!

  def index
    if Current.user.admin?
      @clients = Client.all&.order(:account_id)
    elsif Current.user.user?
      @clients = Client.where("account_id = ? AND name != ?", Current.user.account_id, "New Client")&.order(:account_id)
    else
      flash[:info] = "Update your account details here."
      redirect_to edit_password_path(User)
    end
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:success] = "Successfully added a new client!"
      redirect_to client_path(@client)
    else
      render :new
      flash.now[:alert] = "Woof! Something's not right. Please try again.."
    end
  end

  def show
    @client = Client.find(params[:id])
    @pets = @client.pets
    @walks = @client.walks
    render :show
  end

  def edit
    @client = Client.find(params[:id])
    render :edit
  end

  def update
     @client = Client.find(params[:id])
    if @client.update(client_params)
      flash[:success] = "Client was successfully updated!"
      redirect_to client_url(@client)
    else
      render :edit
      flash.now[:danger] = "Woof! Something's not right. Please try again."
    end
  end

  def export
    if Current.user.admin?
      @clients_all = Client.all&.order(:name)
    else Current.user.user?
      @clients_all = Client.where("account_id = ? AND name != ?", Current.user.account_id, "New Client")&.order(:name)
    end

    clients = Client.includes(:account_name, :name, :email, :phone1, :address, :address2, :city, :state, :zipcode, :pet_id, :rate, :payment_method, :allowance).order("#{params[:name]} asc")

    respond_to do |format|
      format.csv do
        response.headers["Content-Type"] = "text/csv"
        response.headers["Content-Disposition"] = "attachment; filename=clients.csv"
      end
    end
  end

# DESTROY
  def destroy
  end

# SEARCH & SORT
  def search
    @clients = Client.where(
      'LOWER(name) LIKE LOWER(?)
        OR
      LOWER(email) LIKE LOWER(?)',
      "%#{params[:query].downcase}%",
      "%#{params[:query].downcase}%"
      )
  end

  def sort
    @clients = Client.order(params[:sort_by])
  end

# PRIVATE & PARAMS
  private

  def client_params
    params.require(:client).permit(:name, :email, :phone1, :phone2, :address, :address2, :city, :state, :zipcode, :emergcontact_name, :emergcontact_phone, :schedule, :rate, :payment_method, :allowance, :account_id, :user_id, :pet_id, :query, :sort_by)
  end
end

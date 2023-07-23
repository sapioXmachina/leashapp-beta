require "csv"

class InvoicesController < ApplicationController
  before_action :require_user_loggedin!

  def index
    if Current.user.client?
      @walks_all = Walk.where(client_id: Client.where("email = ?", Current.user.email), pet_id: Pet.where("name != ?", "New Pet"))&.order(:startdatetime)
    elsif Current.user.user?
      @walks_all = Walk.where(client_id: Client.where("account_id = ?", Current.user.account_id), pet_id: Pet.where("name != ?", "New Pet"))&.order(:startdatetime)
    else
      @walks_all = Walk.all&.order(:startdatetime)
    end
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.save
      flash[:success] = "Successfully created a new invoice!"
      redirect_to invoice_path(@invoice)
    else
      render :new
      flash.now[:alert] = "Woof! Something's not right. Please try again."
    end
  end

  def show
    @client = Client.find(params[:id])
    # respond_to do |format|
    #   format.html
    #   format.csv { send_data Client.to_csv, filename: "clients-#{DateTime.now.strftime("%d%m%Y%H%M")}.csv"}
    # end

    @walks_all = Walk.where(client_id: @client.id)&.order(:startdatetime)
  end

  def edit
  end

  def export
    if Current.user.admin?
      # @client_all = Client.all
      @walks_all = Walk.all
    elsif Current.user.user?
      # @clients_all = Client.where(account_id: Current.user.account_id, name: Client.where("name != ?", "New Client"))
      @walks_all = Walk.where(client_id: Client.where("account_id = ? AND name != ?", Current.user.account_id, "New Client"))
    else
      @walks_all = Walk.where(client_id: Client.where("email = ? AND name != ?", Current.user.email, "New Client"))
    end

    invoices = Client.includes(:account_name, :name, :nickname, :client, :age, :breed, :neutered, :weight, :groups, :puppies, :notes, :schedule, :last_updated, :created_at).order("#{params[:name]} desc")

    respond_to do |format|
      format.csv do
        response.headers["Content-Type"] = "text/csv"
        response.headers["Content-Disposition"] = "attachment; filename=invoice-client.csv"
      end
    end
  end

  def export_client
    @walks_all = Walk.where(account_id: Current.user.account_id)

    invoices = Walk.includes(:startdatetime, :account_name, :client.name, :pet.name, :group, :duration, :rate, :notes, :status).order("#{params[:startdatetime]} asc")

    respond_to do |format|
      format.csv do
        response.headers["Content-Type"] = "text/csv"
        response.headers["Content-Disposition"] = "attachment; filename=gres-invoice-client2_user.csv"
      end
    end
  end

  def destroy
  end

  private

  def invoice_params
    params.require(:invoice).permit!
  end
end

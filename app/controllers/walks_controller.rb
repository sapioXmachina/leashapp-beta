require "csv"

class WalksController < ApplicationController
  before_action :require_user_loggedin!

  def index
    if Current.user.role == "admin"
      @walks_all = Walk.all&.order(:startdatetime)
    elsif Current.user.role == "user"
      @walks_all = Walk.where(client_id: Client.where("account_id = ? AND name != ?", Current.user.account_id, "New Client"), pet_id: Pet.where("name != ?", "New Pet"))&.order(:startdatetime)
    elsif Current.user.role == "client"
      @walks_all = Walk.where(client_id: Client.where("email = ? AND name != ?", Current.user.email, "New Client"), pet_id: Pet.where("name != ?", "New Pet"))&.order(:startdatetime)
    else
      flash[:notice] = "You are not logged in."
      redirect_to log_in_url
    end
  end

  def new
    @walk = Walk.new
  end

  def create
    @walk = Walk.new(walk_params)
    if @walk.save
      redirect_to walk_path(@walk)
      flash[:success] = "Successfully added a new walk!"
    else
      render :new
      flash.now[:alert] = "Woof! Something's not right. Please try again."
    end
  end

  def show
    @walk = Walk.find(params[:id])
    @pets = @walk.pets
    render :show
  end

  def edit
    @walk = Walk.find(params[:id])
    render :edit
  end

  def update
    @walk = Walk.find(params[:id])
    if @walk.update(walk_params)
      flash[:success] = "Walk was successfully updated!"
      redirect_to walk_url(@walk)
    else
      render :edit
      flash.now[:danger] = "Woof! Something's not right. Please try again."
    end
  end

  def export
    if Current.user.role == "admin"
      @walks_all = Walk.all
    elsif Current.user.role == "user"
      @walks_all = Walk.where(client_id: Client.where("account_id = ? AND name != ?", Current.user.account_id, "New Client"), pet_id: Pet.where("name != ?", "New Pet"))
    else
      @walks_all = Walk.where(client_id: Client.where("email = ? AND name != ?", Current.user.email, "New Client"), pet_id: Pet.where("name != ?", "New Pet"))
    end

    walks = Walk.includes(:startdatetime, :account_name, :client.name, :pet.name, :group, :duration, :rate, :notes, :status).order("#{params[:startdatetime]} asc")

    respond_to do |format|
      format.csv do
        response.headers["Content-Type"] = "text/csv"
        response.headers["Content-Disposition"] = "attachment; filename=walks.csv"
      end
    end
  end

  def destroy
  end

  private

  def walk_params
    params.require(:walk).permit(:startdatetime, :group, :duration, :notes, :status, :pet_id, :client_id, :account_id)
  end
end

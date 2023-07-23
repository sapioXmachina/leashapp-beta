require "csv"

class PetsController < ApplicationController
  before_action :require_user_loggedin!
  include ActiveStorage::SetCurrent

  def index
    if Current.user.role == "admin"
      @query = params[:query]&.strip
      @pets = if @query.present?
                Pet.where('lower(name) LIKE ? OR lower(breed) LIKE ?', "%#{@query.downcase}%", "%#{@query.downcase}%")
              else
                Pet.all
              end

    elsif Current.user.role == "user"
      @query = params[:query]&.strip
      @pets = if @query.present?
                Pet.where(client_id: Client.where("account_id = ?", Current.user.account_id)).where('name != ? OR lower(name) LIKE ? OR lower(breed) LIKE ?', "New Pet", "%#{@query.downcase}%", "%#{@query.downcase}%").order(:name)
              else
                Pet.where(client_id: Client.where("account_id = ?", Current.user.account_id)).where('name != ?', "New Pet").order(:name)
              end


    elsif Current.user.role == "client"
      @pets = if @query.present?
                Pet.where(client_id: Client.where("email = ?", Current.user.email)).where('name != ? OR lower(name) LIKE ? OR lower(breed) LIKE ?', "New Pet", "%#{@query.downcase}%", "%#{@query.downcase}%").order(:name)
              else
                Pet.where(client_id: Client.where("email = ?", Current.user.email)).where('name != ?', "New Pet").order(:name)
              end

    else
      flash[:notice] = "You are not logged in."
      redirect_to log_in_url
    end

    if params[:sort_column].present? && Pet.column_names.include?(params[:sort_column])
      @pets = @pets.order("#{params[:sort_column]} #{params[:sort_direction]}")
    end

  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    if @pet.save
      flash[:success] = "Successfully added a new pet!"
      redirect_to pet_path(@pet)
    else
      render :new
      flash.now[:alert] = "Woof! Something's not right. Please try again."
    end
  end

  def show
    @pet = Pet.find(params[:id])
    @walks = @pet.walks
    render :show
  end

  def edit
    @pet = Pet.find(params[:id])
    render :edit
  end

  def update
    @pet = Pet.find(params[:id])
    if @pet.update(pet_params)
      flash[:notice] = "Pet was successfully updated!"
      redirect_to pet_url(@pet)
    else
      render :edit
      flash.now[:danger] = "Woof! Something's not right. Please try again."
    end
  end

  def export
    if Current.user.admin?
      @pets = Pet.all.order(:name)
    elsif Current.user.user?
      @pets = Pet.where(client_id: Client.where("account_id = ?", Current.user.account_id)).where("name != ?", "New Pet").order(:name)
    else
      @pets = Pet.where(client_id: Client.where("email = ?", Current.user.email)).where("name != ?", "New Pet").order(:name)
    end

    pets = Pet.includes(:account_name, :client.name, :name, :nickname, :age, :breed, :neutered, :weight, :groups, :puppies, :notes, :schedule, :last_updated, :created_at).order("#{params[:name]} asc")

    respond_to do |format|
      format.csv do
        response.headers["Content-Type"] = "text/csv"
        response.headers["Content-Disposition"] = "attachment; filename=pets.csv"
      end
    end
  end

  def destroy
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :nickname, :photo, :breed, :sex, :neutered, :age, :birthday, :weight, :coat, :eyecolor, :features, :allergies, :medical_history, :groups, :puppies, :toys, :treats, :notes, :schedule, :account_id, :client_id)
  end
end

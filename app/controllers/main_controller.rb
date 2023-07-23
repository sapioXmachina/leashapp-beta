class MainController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
  end

  def comingsoon
    flash.now[:info] = "You will automatically be redirected to the previous page in 3.. 2.. 1.."
  end

  def confluence
  end

  def create
    flash[:alert] = "Please contact  INFO@LEASHAPP.IO  regarding this inquiry. We thank you and apologize for the inconvenience!"
    redirect_to root_url
  end

  def about
  end

  def new
    @courier = Courier.new
  end

  def contact
    @client = Client.new
    if Current.user.admin?
      @clients_all = Client.all&.order(:name)
    else
      @clients_all = Client.where("account_id = ?", Current.user.account_id)&.order(:name)
    end
  end

  def courier
  end

  def path
    data = params[:referral_key]
    email = params[:email]
    CourierMailer.mail_method(data, email).deliver
    flash[:success] = "Referral code successfully sent to client's email!"
    redirect_to courier_path
  end

  def send_contact
    require_user_loggedin!
    ContactMailer.contact(params[:message]).deliver
    flash[:success] = "Thank you for your message. We will reach out to you soon!"
    redirect_to root_url
  end

  def contact_us
  end

  def contact_leash
  end

  def privacy_policy
  end

  def cookies_policy
  end

  def eula
  end

  def accessibility
  end

  def terms_service
  end

  def acceptable_use
  end

  def data_request
  end
end

private

def contact_params
  params.require(:client).permit(:id, :name, :email, :account_id, :pet_id, :subject, :data)
  params.require(:account).permit(:id, :account_name, :email, :subject, :data)
end

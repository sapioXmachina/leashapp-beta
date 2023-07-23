class Client < ApplicationRecord
  before_save { email.downcase! }
  belongs_to :account
  belongs_to :user
  has_many :pets
  has_many :walks
  # has_many :pets
  # belongs_to :pet, inverse_of: :client
  # belongs_to :user, inverse_of: :clients
  # has_many :pets, inverse_of: :client
  # has_many :users, inverse_of: :client
  # has_many :walks, inverse_of: :client

  validates :name, presence: true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z0-9\s]/, message: "Only letters, numbers, spaces are allowed." }

  validates :email, presence: true, length: { maximum: 50 }, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: "Must be a valid email address" }, uniqueness: { case_sensitive: false }

  validates :phone1, :allow_blank => true, format: { with: /\A\d{10}\z/, message: "should be a 10-digit number" }

  validates :phone2, :allow_blank => true, format: { with: /\A\d{10}\z/, message: "should be a 10-digit number" }

  validates :address, :allow_blank => true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z0-9\s]/, message: "Only letters, numbers, spaces are allowed." }

  validates :address2, :allow_blank => true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z0-9\s]/, message: "Only letters, numbers, spaces are allowed." }

  validates :city, :allow_blank => true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z\s]/, message: "Only letters and spaces are allowed." }

  validates :state, :allow_blank => true, format: { with: /[A-Z]{2}/, message: "should be state's abbreviation" }

  validates :zipcode, :allow_blank => true, format: { with: /[\d]{5}/, message: "should be a 10-digit number" }

  validates :emergcontact_name, :allow_blank => true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z0-9\s]/, message: "Only letters, numbers, spaces are allowed." }

  validates :emergcontact_phone, :allow_blank => true, format: { with: /\A\d{10}\z/, message: "should be a 10-digit number" }

  validates :schedule, :allow_blank => true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z0-9\s]/, message: "Only letters, numbers, spaces are allowed." }

  validates :rate, :allow_blank => true, numericality: true

  validates :payment_method, :allow_blank => true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z0-9\s]/, message: "Only letters, numbers, spaces are allowed." }

  validates :allowance, :allow_blank => true, numericality: { only_integer: true }

  validates :account_id, :allow_blank => true, numericality: { only_integer: true }

  validates :pet_id, :allow_blank => true, numericality: { only_integer: true }


  # require 'csv'
  # def self.to_csv
  # posts = Client.where(account_id: Current.user.account_id)
  # CSV.generate do |csv|
  #   csv << column_names
  #   posts.each do |post|
  #     csv << post.attributes.values_at(*column_names)
  #   end
  # end
  # end
end

class Account < ApplicationRecord
  has_one_attached :account_logo
  has_many :users
  has_many :clients
  has_many :pets
  has_many :walks
  # has_many :walks

  validates :account_name, presence: true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z0-9\s\/()?!$:+\-,."']+/i, message: "Only letters, numbers, spaces, and .-\' are allowed." }, uniqueness: true

  validates :referral_key, :allow_blank => true, format: { with: /\A[\w]{12}/ }

  validates :account_logo, :allow_blank => true, attached: true, content_type: ["image/png", "image/jpeg", "image/jpg", "image/gif", "image/webp"], size: { less_than: 5.megabytes, message: "should be less than 5MB" }

  validates :account_description, length: { maximum: 200 }, :allow_blank => true, format: { with: /\A[a-zA-Z\d\s\-\/()?!$:+,."']+/, message: "Only letters, numbers, spaces, and -/()?!$:+,\'.\" are allowed." }

  validates :account_rates, :allow_blank => true, numericality: true

  validates :account_admin, :allow_blank => true, numericality: { only_integer: true }

  before_create do |account|
    account.referral_key = generate_unique_key('referral_key')
  end

  private

  def generate_unique_key(field_name)
    loop do
      key = SecureRandom.urlsafe_base64(9).gsub(/-|_/,('a'..'z').to_a[rand(26)])
      break key unless Account.exists?("#{field_name}": key)
    end
  end
end

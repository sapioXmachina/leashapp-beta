class User < ApplicationRecord
  before_save { email.downcase! }
  before_create :confirmation_token

  # email:string
  # password_digest:string
  #
  # password:string virtual
  # password_confirmation:string virtual

  belongs_to :account
  has_many :clients
  has_many :pets
  has_many :walks

  has_secure_password

  # PASSWORD_REQUIREMENTS = /\A
  #   (?=.{8,}) # At least 8 characters long (?=.*\d) # Contain at least one number (?=.* [a-z]) # Contain at least one lowercase letter
  #   (?=.*[A-Z]) # Contain at least one uppercase letter (?=.*[[:^alnum:]J) # Contain at least one symbol
  #   /x

  validates :name, presence: true, length: { maximum: 50 }, format: { with: /\A[a-zA-Z0-9\s]/, message: "Only letters, numbers, spaces are allowed." }

  validates :email, presence: true, length: { maximum: 50 }, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message: "must be a valid email address." }, uniqueness: true
  # validates :email, presence: true, format: {with: /\A[^@\s]+@[^@\s]+\z/, message:"Must be a valid email address"}, uniqueness: {case_sensitive: false}

  validates :role, presence: true, inclusion: ["admin", "user", "client", ], format: { with: /\A[^bfghjkopqvwxyz]{4,6}/ }

  # validates :password
  #, format: PASSWORD_REQUIREMENTS

  validates :account_id, presence: true, numericality: { only_integer: true }

  validates :email_confirmed, inclusion: [true, false]

  validates :confirm_token, :allow_blank => true, format: { with: /\A[\w\-]{22}/ }

  validates :referral_key, :allow_blank => true, format: { with: /\A[\w]{12}/ }

  enum role: [:admin, :user, :client, :account_admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :client
  end

  # def admin
  #   Current.user.where(role: 0)
  # end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def referral_activate
    self.referral_confirmed = true
    self.referral_key = nil
    save!(:validate => false)
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def referral_token
    if self.referral_key.blank?
      self.referral_key = SecureRandom.urlsafe_base64.to_s
    end
  end

  def generate_unique_key(field_name)
    loop do
      key = SecureRandom.urlsafe_base64(9).gsub(/-|_/,('a'..'z').to_a[rand(26)])
      break key unless Account.exists?("#{field_name}": key)
    end
  end
end

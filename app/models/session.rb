class Session < ApplicationRecord
  validates :email, presence: true, length: { maximum: 50 }, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i, message:"must be a valid email address"}, uniqueness: { case_sensitive: false }
  
  validates :password, presence: true
end

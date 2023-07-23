class Walk < ApplicationRecord
  belongs_to :pet
  belongs_to :client
  belongs_to :account
  has_many :pets
  # has_and_belongs_to_many :pets
  # has_and_belongs_to_many :clients, through: :pets
  # has_and_belongs_to_many :accounts, through: :pets

  # belongs_to :client, inverse_of: :walks
  # belongs_to :user, inverse_of: :walks
  # belongs_to :pet, inverse_of: :walks
  # has_many :pets, inverse_of: :walk

  validates :group, :allow_blank => true, inclusion: { in: ["Yes", "No", "Y", "N"], message: "must be Yes/No or Y/N" }

  validates :duration, :allow_blank => true, numericality: true

  validates :notes, :allow_blank => true, length: { maximum: 100 }, format: { with: /\A[a-zA-Z\d\s\-\/()?!$:+,."']+/, message: "Only letters, numbers, spaces, and -/()?!$:+,\'.\" are allowed." }

  validates :status, inclusion: { in: ["Requested", "Scheduled", "Confirmed", "Picked-Up", "Walking", "Dropped-Off", "Completed", "Not Invoiced", "Invoiced", "Paid", "Unpaid"] }

  validates :pet_id, presence: true, numericality: { only_integer: true }

  validates :client_id, presence: true, numericality: { only_integer: true }

  validates :account_id, presence: true, numericality: { only_integer: true }
end

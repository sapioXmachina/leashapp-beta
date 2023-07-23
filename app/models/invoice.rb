class Invoice < ApplicationRecord
  has_many :walks
  has_many :pets
  has_many :clients
  has_many :accounts
end

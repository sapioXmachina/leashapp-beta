class Pet < ApplicationRecord
  has_one_attached :photo
  belongs_to :account
  belongs_to :client
  has_many :walks

  validates :name, presence: true, length: { maximum: 50 }, format: { with: /[a-zA-Z0-9\s]/, message: "Only letters, numbers, spaces are allowed." }

  validates :nickname, :allow_blank => true, length: { maximum: 50 }, format: { with: /[a-zA-Z0-9\s]/, message: "Only letters, numbers, spaces are allowed." }

  validates :photo, :allow_blank => true, attached: true, content_type: ["image/png", "image/jpeg", "image/jpg", "image/gif", "image/webp"], size: { less_than: 5.megabytes, message: "should be less than 5MB" }

  validates :breed, :allow_blank => true, length: { maximum: 100 }, format: { with: /[a-zA-Z\d\s\-\/()?!$:+,."']+/, message: "Only letters, numbers, spaces, and -/()?!$:+,\'.\" are allowed." }

  validates :sex, inclusion: { in: ["Male", "Female", "M", "F"], message: "must be Male/Female or M/F" }

  validates :neutered, inclusion: { in: ["Yes", "No", "Y", "N"], message: "must be Yes/No or Y/N" }

  validates :age, :allow_blank => true, numericality: true

  # validates :birthday, :allow_blank => true, format: { with: /\d{2}\/\d{2}\/\d{4}/, message: "date must be in the following format: mm/dd/yyyy." }

  validates :weight, :allow_blank => true, numericality: true

  validates :coat, :allow_blank => true, length: { maximum: 100 }, format: { with: /[a-zA-Z\d\s\-\/()?!$:+,."']+/, message: "Only letters, numbers, spaces, and -/()?!$:+,\'.\" are allowed." }

  validates :eyecolor, :allow_blank => true, length: { maximum: 100 }, format: { with: /[a-zA-Z\d\s\-\/()?!$:+,."']+/, message: "Only letters, numbers, spaces, and -/()?!$:+,\'.\" are allowed." }

  validates :features, :allow_blank => true, length: { maximum: 100 }, format: { with: /[a-zA-Z\d\s\-\/()?!$:+,."']+/, message: "Only letters, numbers, spaces, and -/()?!$:+,\'.\" are allowed." }

  validates :allergies, :allow_blank => true, length: { maximum: 100 }, format: { with: /[a-zA-Z\d\s\-\/()?!$:+,."']+/, message: "Only letters, numbers, spaces, and -/()?!$:+,\'.\" are allowed." }

  validates :medical_history, :allow_blank => true, length: { maximum: 100 }, format: { with: /[a-zA-Z\d\s\-\/()?!$:+,."']+/, message: "Only letters, numbers, spaces, and -/()?!$:+,\'.\" are allowed." }

  validates :groups, inclusion: { in: ["Yes", "No", "Y", "N"], message: "must be Yes/No or Y/N" }

  validates :puppies, inclusion: { in: ["Yes", "No", "Y", "N"], message: "must be Yes/No or Y/N" }

  validates :toys, :allow_blank => true, length: { maximum: 50 }, format: { with: /[a-zA-Z0-9\s]/, message: "Only letters, numbers, spaces are allowed." }

  validates :treats, :allow_blank => true, length: { maximum: 50 }, format: { with: /[a-zA-Z0-9\s]/, message: "Only letters, numbers, spaces are allowed." }

  validates :notes, :allow_blank => true, length: { maximum: 100 }, format: { with: /[a-zA-Z\d\s\-\/()?!$:+,."']+/, message: "Only letters, numbers, spaces, and -/()?!$:+,\'.\" are allowed." }

  validates :schedule, :allow_blank => true, length: { maximum: 50 }, format: { with: /[a-zA-Z0-9\s]/, message: "Only letters, numbers, spaces are allowed." }

  validates :client_id, :allow_blank => true, numericality: { only_integer: true }

  validates :account_id, :allow_blank => true, numericality: { only_integer: true }
end

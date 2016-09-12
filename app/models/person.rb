class Person < ApplicationRecord
  has_many :phone_numbers
  has_many :email_addresses

  validates :first_name, :last_name, presence: true
end

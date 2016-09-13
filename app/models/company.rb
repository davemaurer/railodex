class Company < ApplicationRecord
  has_many :phone_numbers

  validates :name, presence: true
end

class Company < ApplicationRecord
  include Contact

  validates :name, presence: true
end

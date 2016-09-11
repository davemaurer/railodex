class PhoneNumber < ApplicationRecord
  has_one :person

  validates :number, :person_id, presence: true
end

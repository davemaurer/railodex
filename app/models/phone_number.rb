class PhoneNumber < ApplicationRecord
  belongs_to :person, required: false

  validates :number, :person_id, presence: true
end

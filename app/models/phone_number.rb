class PhoneNumber < ApplicationRecord
  belongs_to :person, required: false
  belongs_to :company, required: false

  validates :number, :person_id, presence: true
end

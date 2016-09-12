class EmailAddress < ApplicationRecord
  belongs_to :person, required: false

  validates :address, :person_id, presence: true
end

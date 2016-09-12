class EmailAddress < ApplicationRecord
  belongs_to :person, required: false

  validates :address, presence: true
end

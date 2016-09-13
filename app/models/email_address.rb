class EmailAddress < ApplicationRecord
  belongs_to :contact, polymorphic: true, required: false

  validates :address, :contact_id, presence: true
end

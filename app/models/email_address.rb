class EmailAddress < ApplicationRecord
  belongs_to :contact, required: false, polymorphic: true

  validates :address, :contact_id, presence: true
end

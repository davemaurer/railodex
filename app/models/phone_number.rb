class PhoneNumber < ApplicationRecord
  belongs_to :contact, required: false, polymorphic: true

  validates :number, :contact_id, presence: true
end

class PhoneNumber < ApplicationRecord
  belongs_to :contact, polymorphic: true, required: false

  validates :number, :contact_id, presence: true
end

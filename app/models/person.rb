class Person < ApplicationRecord
  include Contact

  belongs_to :user, required: false

  validates :first_name, :last_name, presence: true

  def to_s
    "#{last_name}, #{first_name}"
  end
end

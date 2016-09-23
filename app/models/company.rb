class Company < ApplicationRecord
  include Contact

  belongs_to :user, required: false
  
  validates :name, presence: true

  def to_s
    "#{name}"
  end
end

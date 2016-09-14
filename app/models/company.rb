class Company < ApplicationRecord
  include Contact

  validates :name, presence: true

  def to_s
    "#{name}"
  end
end

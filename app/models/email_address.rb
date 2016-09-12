class EmailAddress < ApplicationRecord
  belongs_to :person, required: false
end

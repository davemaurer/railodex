require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new }
  let(:person_one) { Person.new(first_name: 'Bob', last_name: 'Smith') }

  it 'has associated people' do
    user.people.push(person_one)
    expect(user.people.length).to eq(1)
  end
end

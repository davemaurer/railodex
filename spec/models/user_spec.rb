require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { Fabricate(:user) }
  let(:person_one) { Person.new(first_name: 'Bob', last_name: 'Smith') }

  it 'has associated people' do
    user.people.push(person_one)
    expect(user.people.length).to eq(1)
  end

  it 'builds associated people' do
    person_1 = Fabricate(:person)
    person_2 = Fabricate(:person)
    [person_1, person_2].each do |person|
      expect(user.people).not_to include(person)
      user.people << person
      expect(user.people).to include(person)
    end
  end
end

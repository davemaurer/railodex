require 'rails_helper'

describe 'this person view', type: :feature do
  let(:person) { Person.create(first_name: 'Mr', last_name: 'Rogers') }

  before(:each) do
    person.phone_numbers.create(number: '555-5555')
    person.phone_numbers.create(number: '555-8888')
    visit person_path(person)
  end

  it 'shows the phone numbers' do
    person.phone_numbers.each do |phone|
      expect(page).to have_content(phone.number)
    end
  end
end

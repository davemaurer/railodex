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

  it 'has a link to add a new phone number' do
    expect(page).to have_link('Add new phone number', href: new_phone_number_path(person_id: person.id))
  end

  it 'adds a new phone number' do
    page.click_link('Add new phone number')
    page.fill_in('Number', with: '555-4321')
    page.click_button('Create Phone number')

    expect(current_path).to eq(person_path(person))
    expect(page).to have_content('555-4321')
  end

  it 'has an edit link for each phone number' do
    person.phone_numbers.each do |phone|
      expect(page).to have_link('edit', href: edit_phone_number_path(phone))
    end
  end
end

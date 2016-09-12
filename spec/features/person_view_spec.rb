require 'rails_helper'

describe 'this person view', type: :feature do
  let(:person) { Person.create(first_name: 'Mr', last_name: 'Rogers') }

  describe 'phone numbers' do
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

    it 'edits a phone number' do
      phone = person.phone_numbers.first
      old_number = phone.number

      first('.phone-number').click_link('edit')
      page.fill_in('Number', with: '555-9999')
      page.click_button('Update Phone number')

      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('555-9999')
      expect(page).to_not have_content(old_number)
    end

    it 'has a delete link for each phone number' do
      person.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end

    it 'can delete a phone number' do
      expect(page).to have_content('555-5555')

      first('.phone-number').click_link('delete')

      expect(current_path).to eq(person_path(person))
      expect(page).not_to have_content('555-5555')
    end
  end

  describe 'email addresses' do
    before(:each) do
      person.email_addresses.create(address: 'batman@batman.com')
      person.email_addresses.create(address: 'robin@robin.com')
      visit person_path(person)
    end

    it 'has li tags for each email address' do
      expect(page).to have_selector('li', text: 'batman@batman.com')
    end

    it 'has an add email address link' do
      page.click_link('Add new email address', href: new_email_address_path(person_id: person.id))

      expect(current_path).to eq(new_email_address_path)
    end

    it 'adds a new email address to the page' do
      page.click_link('Add new email address')
      page.fill_in('Address', with: 'newaddress@newaddress.com')
      page.click_button('Create Email address')

      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('newaddress@newaddress.com')
    end

    it 'has an edit link for each email address' do
      person.email_addresses.each do |email|
        expect(page).to have_link('edit', href: edit_email_address_path(email))
      end
    end

    it 'can edit an email address' do
      email = person.email_addresses.first
      old_address = email.address

      first('.email-address').click_link('edit')
      page.fill_in('Address', with: 'betteraddress@me.com')
      page.click_button('Update Email address')

      expect(current_path).to eq(person_path(person))
      expect(page).to have_content('betteraddress@me.com')
      expect(page).not_to have_content(old_address)
    end
  end
end

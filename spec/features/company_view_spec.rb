require 'rails_helper'

describe 'this company view', type: :feature do
  let(:company) { Company.create(name: 'Robco') }

  describe 'phone numbers' do
    before(:each) do
      company.phone_numbers.create(number: '555-5555')
      company.phone_numbers.create(number: '555-8888')
      visit company_path(company)
    end

    it 'shows the phone numbers' do
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add new phone number', href: new_phone_number_path(contact_id: company.id, contact_type: 'Company'))
    end

    it 'adds a new phone number' do
      page.click_link('Add new phone number')
      page.fill_in('Number', with: '555-4321')
      page.click_button('Create Phone number')

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-4321')
    end

    it 'has an edit link for each phone number' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it 'can edit a phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      first('.phone-number').click_link('edit')
      page.fill_in('Number', with: '555-9999')
      page.click_button('Update Phone number')

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9999')
      expect(page).to_not have_content(old_number)
    end

    it 'has a delete link for each phone number' do
      company.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end

    it 'can delete a phone number' do
      phone = company.phone_numbers.first
      old_number = phone.number

      expect(page).to have_content(old_number)

      first('.phone-number').click_link('delete')

      expect(current_path).to eq(company_path(company))
      expect(page).not_to have_content(old_number)
    end
  end

  describe 'email addresses' do
    before(:each) do
      company.email_addresses.create(address: 'Robco@company.com')
      company.email_addresses.create(address: 'CoolCo@company.com')
      visit company_path(company)
    end

    xit 'has li tags for each email address' do
      expect(page).to have_selector('li', text: 'Robco@company.com')
    end

    xit 'has an add email address link' do
      page.click_link('Add new email address', href: new_email_address_path(contact_id: company.id))

      expect(current_path).to eq(new_email_address_path)
    end

    xit 'adds a new email address to the page' do
      page.click_link('Add new email address')
      page.fill_in('Address', with: 'newaddress@newaddress.com')
      page.click_button('Create Email address')

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('newaddress@newaddress.com')
    end

    xit 'has an edit link for each email address' do
      company.email_addresses.each do |email|
        expect(page).to have_link('edit', href: edit_email_address_path(email))
      end
    end

    xit 'can edit an email address' do
      email = company.email_addresses.first
      old_address = email.address

      first('.email-address').click_link('edit')
      page.fill_in('Address', with: 'betteraddress@company.com')
      page.click_button('Update Email address')

      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('betteraddress@company.com')
      expect(page).not_to have_content(old_address)
    end

    xit 'has a delete link for each email address' do
      company.email_addresses.each do |email|
        expect(page).to have_link('delete', href: email_address_path(email))
      end
    end

    xit 'can delete an email address' do
      email = company.email_addresses.first
      old_address = email.address

      expect(page).to have_content(old_address)

      first('.email-address').click_link('delete')

      expect(current_path).to eq(company_path(company))
      expect(page).not_to have_content(old_address)
    end
  end
end

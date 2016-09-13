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
end

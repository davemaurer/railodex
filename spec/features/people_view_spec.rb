require 'spec_helper'
require 'capybara/rails'
require 'capybara/rspec'

describe 'the people view', type: :feature do

  context 'when logged in' do
    let(:user) { Fabricate(:user) }

    it 'displays people associated with the user' do
      person_1 = Fabricate(:person)
      person_1.user = user
      person_1.save
      login_as(user)
      visit(people_path)
      expect(page).to have_text(person_1.first_name)
      expect(page).to have_text(person_1.last_name)
    end

    it 'does not display people associated with another user' do
      user_1 = Fabricate(:user)
      user_2 = Fabricate(:user)
      person_2 = Person.new(first_name: 'Bob', last_name: 'Barker', user_id: user_2.id)
      person_2.save
      login_as(user_1)
      visit(people_path)
      expect(page).not_to have_text(person_2.first_name)
      expect(page).not_to have_text(person_2.last_name)
    end
  end
end

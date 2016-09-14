require 'rails_helper'

RSpec.describe Person, type: :model do
  let(:person) { Person.new(first_name: 'Luke', last_name: 'Skywalker') }

  it 'is valid' do
    expect(person).to be_valid
  end

  it 'is invalid without a first name' do
    person.first_name = nil

    expect(person).not_to be_valid
  end

  it 'is invalid without a first name' do
    person.last_name = nil

    expect(person).not_to be_valid
  end

  it 'responds with its created phone numbers' do
    person.phone_numbers.build(number: '555-8888')
    expect(person.phone_numbers.map(&:number)).to eq(['555-8888'])
  end

  it 'responds with its created email addresses' do
    person.email_addresses.build(address: 'ohyesh@me.com')
    expect(person.email_addresses.map(&:address)).to eq(['ohyesh@me.com'])
  end

  it 'converts to a string with last name, first name' do
    expect(person.to_s).to eq('Skywalker, Luke')
  end
end

require 'rails_helper'

RSpec.describe Company, type: :model do
  let(:company) { Company.new(name: 'CoolCo') }

  it 'exists' do
    expect(company).to be_valid
  end

  it 'is not valid without a name' do
    company.name = nil
    expect(company).not_to be_valid
  end

  it 'responds with its created phone numbers' do
    company.phone_numbers.build(number: '555-0987')
    expect(company.phone_numbers.map(&:number)).to eq(['555-0987'])
  end

  it 'responds with its created email addresses' do
    company.email_addresses.build(address: 'Robco@comp.com')
    expect(company.email_addresses.map(&:address)).to eq(['Robco@comp.com'])
  end

  it 'converts to a string with name' do
    expect(company.to_s).to eq('CoolCo')
  end
end

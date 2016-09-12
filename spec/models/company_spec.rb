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
end

require 'spec_helper'

describe SessionsController do
  describe '#create' do
    it 'creates a user from twitter data' do
      @request.env['omniauth.auth'] = {
        provider: 'twitter',
        info: { name: 'Luke Skywalker' },
        uid: 'abc123'
      }

      post :create
      user = User.find_by_uid_and_provider('abc123', 'twitter')
      expect(user.name).to eq('Luke Skywalker')
    end
  end
end

require 'spec_helper'

describe SessionsController do
  describe '#create' do
    it 'authenticates a new user at login' do
      @request.env['omniauth.auth'] = {
        provider: 'twitter',
        info: { name: 'Luke Skywalker' },
        uid: 'abc123'
      }
      post :create
      user = User.find_by_uid_and_provider('abc123', 'twitter')

      expect(controller.current_user.id).to eq(user.id)
    end
  end

  it 'logs in an existing user' do
    @request.env['omniauth.auth'] = {
      provider:'twitter',
      info: {name: 'Han Solo'},
      uid: 'oicu812'
    }
    user = User.create(provider: 'twitter', uid: 'oicu812', name: 'Han Solo')

    post :create
    expect(User.count).to eq(1)
    expect(controller.current_user.id).to eq(user.id)
  end

  it 'redirects to the companies page' do
    request.env['omniauth.auth'] = {
      provider: 'twitter',
      info:     {name: 'Darth Vader'},
      uid:      '555uhu'
    }
    User.create(provider: 'twitter', uid: '555uhu', name: 'Darth Vader')
    post :create
    expect(response).to redirect_to(root_path)
  end
end

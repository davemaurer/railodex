require 'spec_helper'

describe SessionsController do
  before(:each) do
    Rails.application.routes.draw do
      root 'site#index'

      get '/auth/twitter', as: :login

      get '/auth/:provider/callback', to: 'sessions#create'

      get '/logout', as: :logout, to: 'sessions#destroy'
      resources :sessions, only: [:create, :destroy]
    end
  end

  after(:each) do
    Rails.application.reload_routes!
  end

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

  it 'redirects to the site page' do
    @request.env['omniauth.auth'] = {
      provider: 'twitter',
      info:     {name: 'Darth Vader'},
      uid:      '555uhu'
    }
    User.create(provider: 'twitter', uid: '555uhu', name: 'Darth Vader')
    post :create
    expect(response).to redirect_to(root_path)
  end

  it 'deletes the session when the user logs out' do
    @request.env['omniauth.auth'] = {
      provider: 'twitter',
      info: {name: 'Darth Vader'},
      uid: '555uhu'
    }
    user = User.create(provider: 'twitter', uid: '555uhu', name: 'Darth Vader')
    post :create

    expect(controller.current_user.id).to eq(user.id)
    get :destroy
    expect(controller.current_user).to eq(nil)
  end

  it 'redirects to the root path once the session is deleted' do
    @request.env['omniauth.auth'] = {
      provider: 'twitter',
      info: {name: 'Darth Vader'},
      uid: '555uhu'
    }
    user = User.create(provider: 'twitter', uid: '555uhu', name: 'Darth Vader')
    post :create

    expect(controller.current_user.id).to eq(user.id)
    get :destroy
    expect(response).to redirect_to(root_path)
  end
end

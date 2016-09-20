Rails.application.routes.draw do
  root 'site#index'

  get '/auth/twitter', as: :login

  get '/auth/:provider/callback', to: 'sessions#create'

  get '/logout', as: :logout, to: 'sessions#destroy'


  resources :sessions, only: [:create, :destroy]
  resources :companies
  resources :email_addresses, except: [:index, :show]
  resources :phone_numbers, except: [:index, :show]
  resources :people
end

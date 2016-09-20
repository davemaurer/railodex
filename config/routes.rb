Rails.application.routes.draw do
  root 'site#index'

  get '/login' => redirect('/auth/twitter'), as: :login

  get '/auth/:provider/callback', to: 'sessions#create'

  resources :sessions, only: :create
  resources :companies
  resources :email_addresses, except: [:index, :show]
  resources :phone_numbers, except: [:index, :show]
  resources :people
end

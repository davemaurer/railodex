Rails.application.routes.draw do
  root 'companies#index'

  get '/auth/:provider/callback', to: 'sessions#create'

  resources :sessions, only: :create
  resources :companies
  resources :email_addresses, except: [:index, :show]
  resources :phone_numbers, except: [:index, :show]
  resources :people
end

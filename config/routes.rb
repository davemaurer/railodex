Rails.application.routes.draw do
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :companies
  resources :email_addresses, except: [:index, :show]
  resources :phone_numbers, except: [:index, :show]
  resources :people
end

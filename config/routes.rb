Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Users
  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  # Products
  resources :products

  # Content Pages
  get 'content/index'
  get '/about', to: 'content#about'

  root 'content#index'
end

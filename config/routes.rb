Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Users
  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  # Products
  resources :products, param: :slug

  # Cart
  resource :cart, only: [:show] do
    put 'add/:product_id', to: 'carts#add', as: :add_to
    put 'remove/:product_id', to: 'carts#remove', as: :remove_from
    put 'remove_one/:product_id', to: 'carts#removeone', as: :remove_one
  end

  # Checkout
  resource :checkout, controller: 'checkout'

  # Orders
  resources :orders

  # Content Pages
  get 'content/index'
  get '/about', to: 'content#about'

  root 'content#index'
end

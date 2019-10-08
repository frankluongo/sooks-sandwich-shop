Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # Users
  devise_for :users, controllers: {
    registrations: 'registrations'
  }

  as :user do
    get 'login', to: 'devise/sessions#new'
  end

  # Products
  resources :products, param: :slug

  # Cart
  resource :cart, only: [:show] do
    post 'add/:product_id', to: 'carts#add', as: :add_to
    put 'remove/:product_id', to: 'carts#remove', as: :remove_from
    put 'remove_one/:product_id', to: 'carts#removeone', as: :remove_one
  end

  namespace :cart, path: 'cart' do
    resources :line_items, only: [:new, :create, :update, :destroy] do
      post 'update-quantity', to: 'line_items#update_quantity'
      post 'remove-item', to: 'line_items#destroy'
    end
  end

  # Checkout
  resource :checkout, controller: 'checkout' do
    get 'shipping', to: 'checkout#shipping'
  end

  # Orders
  resources :orders

  # Content Pages
  get 'content/index'
  get '/about', to: 'content#about'

  root 'content#index'
end

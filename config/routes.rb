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
  resource :checkout, controller: 'checkout', only: [:new, :create, :update]

  namespace :checkout, path: 'checkout' do
    resource :shipping, only: :show, controller: 'shipping' do
      post 'add-shipping', to: 'shipping#add_shipping'
      patch 'add-shipping', to: 'shipping#add_shipping'
    end

    resource :shipping_method, only: :show, controller: 'shipping_method', path: 'shipping-method' do
      post 'add-shipping-method', to: 'shipping_method#add_shipping_method'
    end
  end

  # Orders
  resources :orders

  # Content Pages
  get 'content/index'
  get '/about', to: 'content#about'

  root 'content#index'
end

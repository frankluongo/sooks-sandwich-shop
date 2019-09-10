Rails.application.routes.draw do
  get 'content/index'
  get '/about', to: 'content#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'content#index'
end

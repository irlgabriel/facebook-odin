Rails.application.routes.draw do
  get 'home', to: 'home#index', as: :home
  get 'feed/(:notification_id)', to: 'feed#index', as: :feed 
  get 'profile/:id', to: 'home#profile', as: :profile

  #friends
  get 'friends/find', to: 'friends#suggestions'
  get 'friends/(:notification_id)', to: 'friends#requests', as: :friends
  post 'friends/accept/:from_id', to:'friends#accept', as: :accept_request
  post 'friends/decline/:from_id', to:'friends#decline', as: :decline_request
  post 'friends/send/:to_id', to:'friends#send_fr', as: :send_request
  get 'friends/index', to: 'friends#index'
  root to: 'home#index'


  resources :posts do
    resources :comments
  end

  post 'like', to: 'likes#create'
  get 'likes', to: 'likes#index'



  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
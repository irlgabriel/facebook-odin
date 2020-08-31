Rails.application.routes.draw do
  get 'home', to: 'home#index', as: :home
  get 'feed/(:notification_id)', to: 'feed#index', as: :feed 
  get 'profile/:id', to: 'home#profile', as: :profile

  #friends
  get 'friends/find', to: 'friends#suggestions'
  post 'friends/accept/:from_id', to:'friends#accept', as: :accept_request
  post 'friends/decline/:from_id', to:'friends#decline', as: :decline_request
  post 'friends/send/:to_id', to:'friends#send_fr', as: :send_request
  get 'friends/index', to: 'friends#index', as: :friends_index
  get 'friends/(:notification_id)', to: 'friends#requests', as: :friends
  post 'friends/(:friend_id)', to: 'friends#delete_friendship', as: :delete_friend
  root to: 'home#index'

  #photo uploads
  put '/upload_profile_picture', to: 'uploads#upload_profile_picture', as: :upload_profile_picture
  put '/upload_cover_picture', to: 'uploads#upload_cover_picture', as: :upload_cover_picture

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
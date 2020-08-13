Rails.application.routes.draw do
  get 'home', to: 'home#index', as: :home
  get 'feed', to: 'feed#index', as: :feed 
  get 'profile/:id', to: 'home#profile', as: :profile
  get 'friends', to: 'friends#home'

  resources :posts
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end

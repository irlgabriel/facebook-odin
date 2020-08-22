Rails.application.routes.draw do
  get 'home', to: 'home#index', as: :home
  get 'feed', to: 'feed#index', as: :feed 
  get 'profile/:id', to: 'home#profile', as: :profile
  get 'friends', to: 'friends#home'
  root to: 'home#index'
  resources :posts do
    resources :comments
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  put 'upload', to: 'users/uploads#upload_image'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

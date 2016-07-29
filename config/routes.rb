Rails.application.routes.draw do
  resources :comments
  resources :posts
  resources :users 
  resources :sessions, only: [:create, :update, :destroy]

  get "signup" => "users#new", as: :signup
  get "login" => "sessions#new", as: :login
  get "logout" => "sessions#destroy", as: :logout

  root 'posts#index', as: :root
end

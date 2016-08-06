Rails.application.routes.draw do   
  resources :users
  resources :posts do
    resources :comments, only: [:new, :edit, :create, :destroy]
  end

  resources :sessions, only: [:new, :create, :destroy]

  get "signup" => "users#new", as: :signup
  get "login" => "sessions#new", as: :login
  get "logout" => "sessions#destroy", as: :logout

  root 'posts#index', as: :root
end

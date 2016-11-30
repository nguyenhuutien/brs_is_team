Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "registrations",
    omniauth_callbacks: "omniauth_callbacks"
  }
  root "pages#index"
  get "/pages/:page", to: "pages#show"

  resources :users
  resources :feed_backs, only: [:new, :create]
  resources :books
  resources :reviews
  resources :categories
  resources :follows, only: [:create, :destroy]
end
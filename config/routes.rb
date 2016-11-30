Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "registrations",
    omniauth_callbacks: "omniauth_callbacks"
  }
  root "pages#index"
  get "/pages/:page", to: "pages#show"

  resources :users do
    resources :list_books, only: :index
    resources :requests, except: [:show, :edit, :update]
  end
  resources :follows, only: [:create, :destroy]
  resources :activities, only: :index do
    resources :likes, only: [:create, :destroy]
  end
  resources :categories, only: [:show, :index]
  resources :books, only: [:show, :index]
  resources :reviews
  resources :marks, only: :update
  resources :feed_backs, only: [:new, :create]

  namespace :admin do
    root to: "books#index", as: :root
    resources :categories
    resources :books
    resources :users
  end
end

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "registrations",
    omniauth_callbacks: "omniauth_callbacks"
  }
  root "pages#index"
  get "/pages/:page", to: "pages#show"

  resources :users do
    resources :list_books, only: :index
  end
  resources :feed_backs, only: [:new, :create]
  resources :books, only: [:show, :index]
  resources :reviews
  resources :categories, only: [:show, :index]
  resources :follows, only: [:create, :destroy]
  resources :marks, only: :update
end

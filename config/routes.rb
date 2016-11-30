Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "registrations",
    omniauth_callbacks: "omniauth_callbacks"
  }
  root "pages#index"
  get "/pages/:page", to: "pages#show"

  resources :users do
    resources :list_books
  end
  resources :feed_backs, only: [:new, :create]
  resources :books
  resources :reviews
  resources :categories
  resources :follows, only: [:create, :destroy]
  resources :marks
end

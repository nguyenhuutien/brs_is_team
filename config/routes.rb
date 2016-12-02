Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
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
  resources :activities
  resources :categories, only: [:show, :index]
  resources :books, only: [:show, :index] do
    resources :reviews
  end
  resources :reviews, only: :show do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:new, :create, :destroy, :edit, :update]
  end
  resources :marks, only: :update
  resources :feed_backs, only: [:new, :create]

  namespace :admin do
    root to: "books#index", as: :root
    resources :categories
    resources :books
    resources :users, only: [:index, :show, :destroy]
    resources :requests, only: [:index, :update]
  end
end
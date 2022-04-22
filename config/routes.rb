Rails.application.routes.draw do
  #scope '(:locale)', locale: /#{I18n.available_locales.map(&:to_s).join("|")}/ do

  root 'static_pages#home'
  get     '/help',     to: 'static_pages#help'
  get     '/about',    to: 'static_pages#about'
  get     '/contact',  to: 'static_pages#contact'
  get     '/search',   to: 'movies#search'
  get     '/show',     to: 'movies#show'
  get     '/signup',   to: 'users#new'
  post    '/signup',   to: 'users#create'
  get     '/login',    to: 'sessions#new'
  post    '/login',    to: 'sessions#create'
  delete  '/logout',   to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :movies
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :comments,            only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]
end
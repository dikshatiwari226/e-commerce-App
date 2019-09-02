Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :products

  root 'products#index'

  namespace :admin, module: nil  do
    root "admin#index"
    resources :users
  end
  
end

Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :products

  root 'products#index'


  namespace :admin, module: nil  do
    root "admin#index"
    resources :users
  end
  get 'category/:id/products' => "products#index"

  get 'product/:id' => "products#product_details"
  get 'products_all' => "products#all_product"

  namespace :products do
  	post "/wishlist/:id", action: :add_wishlist, as: :add_wishlist
  end

  get '/wishlist' => "products#wishlist"
end

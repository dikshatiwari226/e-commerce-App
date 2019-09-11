Rails.application.routes.draw do
  devise_for :users
  resources :categories
  
  resources :products 
  resources :rating_reviews
  resources :address
  # resources :charges, only: [:new, :create]
  # resources :orders
  root 'products#index'
  #=========== Charges ==============
  post 'charges' => "charges#new"

  namespace :admin, module: nil  do
    root "admin#index"
    resources :users
  end
  
  get 'category/:id/products' => "products#index"

  get 'product/:id' => "products#product_details"
  get 'products_all' => "products#all_product"
  get '/product/:id' => "products#show"

  # ===========    User Profile =============
  get 'user_profile' => "orders#user_profile" 
  #  ===========  Order Details  =============
  post 'order' => "orders#all_order_show"
  get 'orders_history' => "orders#index"

  get 'order/pdf' => "orders#index"

  # ================ Billing & shipping address ==========
  get '/billing_address' => "orders#billing_address"

  resources :products do
  	get "/wishlist", action: :add_wishlist, as: :add_wishlist
    # get "/cart/:id", action: :add_to_cart, as: :add_to_cart
    get "/cart" => "products#add_to_cart"
  end

  delete 'remove_wishlist_item/:id' => "products#remove_wishlist", as: :remove_wishlist
  delete 'remove_cart_item/:id' => "products#remove_cart", as: :remove_cart
  
  get '/wishlist' => "products#wishlist"
  get '/cart' => "products#cart"

  # ============= cart item add and reduce ======
  post 'cart_items/:id/add' => "cart_items#add_quantity", as: "cart_item_add"
  post 'cart_items/:id/reduce' => "cart_items#reduce_quantity", as: "cart_item_reduce"

end

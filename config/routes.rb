Rails.application.routes.draw do
  devise_for :users
  resources :categories

  resources :rating_reviews
  resources :addresses

  # resources :charges, only: [:new, :create]
  # resources :orders
  root 'products#index'
  #=========== Charges ==============
  post 'charges/new' => "charges#new"
  get 'charges/new' => "charges#new"

  get 'charges/create' => 'charges#create'

  # user
  # get 'user_all' => 'orders#user_all'

  namespace :admin, module: nil  do
    root "admin#index"
    resources :users
  end

  post '/admin/users/:id/edit' => "users#edit"
  
  get 'category/:id/products' => "products#index"

  get 'product/:id' => "products#product_details"
  get 'products_all' => "products#all_product"
  get '/product/:id' => "products#show"

  # ===========    User Profile =============
  get 'user_profile' => "orders#user_profile" 
  #  ===========  Order Details  =============
  post 'order' => "orders#all_order_show"
  get 'orders_history' => "orders#index"

  # =====  Order Review
  get 'order_review/:id' => 'orders#order_review'

  get 'order/pdf' => "orders#index"

  # # ================ Billing & shipping address ==========
  # get '/billing_address' => "orders#billing_address"

  # resources :products do
  # 	get "/wishlist", action: :add_wishlist, as: :add_wishlist
  #   # get "/cart/:id", action: :add_to_cart, as: :add_to_cart
  #   get "/cart" => "carts#add_to_cart"
  # end
  resources :products do 
    get "/wishlist" => "carts#add_wishlist"
    get "/cart" => "carts#add_to_cart"
  end

  get "/update_cart_item_quantity/:type/:cart_item_id" => "carts#update_cart_item_quantity", as: :update_cart_item_quantity


  delete 'remove_wishlist_item/:id' => "carts#remove_wishlist", as: :remove_wishlist
  delete 'remove_cart_item/:id' => "carts#remove_cart", as: :remove_cart
  
  get '/wishlist' => "carts#wishlist"
  get '/cart' => "carts#cart"

  # ============= cart item add and reduce ======
  # post 'cart_items/:id/add' => "cart_items#add_quantity", as: "cart_item_add"
  # post 'cart_items/:id/reduce' => "cart_items#reduce_quantity", as: "cart_item_reduce"

end

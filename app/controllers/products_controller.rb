class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  

  def product_details
    @product = Product.find(params[:id])
    @reviews = @product.rating_reviews.to_a
    @avg_rating = if @reviews.blank?
      0
    else
      @product.rating_reviews.average(:rating).round(2)
    end
  end

  def all_product
    @products = Product.all.paginate(page: params[:page], per_page: 4)
  end

  # def add_wishlist
  #   @product = Product.friendly.find(params[:product_id])
  #   if user_signed_in?
  #     existing_wishlist = current_user.wishlists.where(product_id: @product.id).uniq
  #     if existing_wishlist.present?
  #       flash[:notice] = "Product is already into your wishlist"
  #       redirect_to root_path
  #     else
  #       current_user.wishlists.create(product_id: @product.id)
  #       flash[:notice] = "Product has been added into your wishlist"
  #       redirect_to root_path
  #     end
  #   else
  #     flash[:notice] = "You need to sign_in or sign_up"
  #     redirect_to "/users/sign_in"
  #   end
  # end

  # def add_to_cart
  #   # byebug
  #   # @product = Product.find(params[:product_id])
  #   # if user_signed_in?
  #   #     @user = current_user
  #   #     @cart = Cart.find_or_create_by(user_id: @user.id, is_done: false)
  #   #     @cart_items = @cart.cart_items.where(product_id: params[:product_id])
  #   #     if @cart_items.any?
  #   #       cart_item = @cart_items.first
  #   #       cart_item.quantity = cart_item.quantity + 1 
  #   #       cart_item.unit_price = cart_item.quantity * cart_item.price 
  #   #       cart_item.save
  #   #     else
  #   #       @cart.cart_items.create(product_id: params[:product_id], quantity: 1, price: @product.price, unit_price: @product.price)
  #   #     end
  #   #     redirect_to root_path, notice: "Product successfully added to the cart"
  #   # else
  #   #   flash[:notice] = "You need to sign_in or sign_up"
  #   #   redirect_to "/users/sign_in"
  #   # end

  #   @product = Product.find(params[:product_id])
  #   if @product
  #     if user_signed_in?
  #       if current_cart.present?
  #         cart_item = current_cart.cart_items.find_by_product_id(@product.id)
  #         if cart_item.blank?
  #           cart_item = current_cart.cart_items.new(product_id: @product.id)
  #         end
  #         cart_item.unit_price = @product.price
  #         cart_item.price = cart_item.unit_price * cart_item.quantity
  #         if (cart_item.save)
  #           flash[:notice] = "Product has been added into your cart"
  #           redirect_to root_path
  #         end
  #       else
  #       end
  #     else
  #       flash[:notice] = "you need to sign in or sign up"
  #       redirect_to "/users/sign_in"
  #     end
  #   end

  # end

  

  
  #   @product = Product.friendly.find(params[:product_id])
    
    # if user_signed_in?
    #   existing_cart = current_user.carts.where(product_id: @product.id)
    #   if existing_cart.present?
    #     flash[:notice] = "Product is already into your cart"
    #     redirect_to root_path
    #   else
    #     current_user.carts.create(product_id: @product.id)
    #     flash[:notice] = "Product has been added into your cart"
    #     redirect_to root_path
    #   end
    # else
    #   flash[:notice] = "You need to sign_in or sign_up"
    #   redirect_to "/users/sign_in"
    # end
  # end

  # def remove_wishlist
  #   # @product = Product.friendly.find(params[:id])
  #   @product =  Product.unscoped.friendly.find(params[:id])
  #   @remove_wishlist = current_user.wishlists.where(product_id: @product.id).first.destroy
  #   redirect_to "/wishlist"
  # end

  # def wishlist
  #   # byebug
  #   if current_user.present?
  #     product_ids = current_user.wishlists.map(&:product_id).uniq
  #     @products = Product.unscoped.where(id: product_ids).uniq
  #   else
  #     redirect_to new_user_session_path
  #     # redirect_back fallback_location: root_path
  #     # product_ids = current_user.wishlists.map(&:product_id)
  #     # @products = Product.where(id: product_ids)
  #   end 
  # end

  # def cart
  #   if current_user.present?
  #     current_cart.cart_items.each do |cart_item|
  #       if cart_item.product.nil?
  #         cart_item.destroy!
  #       end
  #     end
  #     # redirect_to "/cart"
  #   else
  #     redirect_to new_user_session_path
  #   end
  # end

  # GET /products
  # GET /products.json
  def index
    if params[:id].present?
      @category = Category.find(params[:id])
      @products_all = @category.products.paginate(page: params[:page], per_page: 4)
      
    elsif 
      if params[:search].present?
      @products_all = Product.where("lower(name) LIKE :prefix OR lower(name) LIKE :prefix", prefix: "%#{params[:search].downcase}%").paginate(page: params[:page], per_page: 2)
      end
    else
      @products_all = Product.all.paginate(page: params[:page], per_page: 4)
    end
    # if params[:search].present?
    #   @products = Product.where("lower(name) LIKE :prefix OR lower(price) LIKE :prefix", prefix: "%#{params[:search].downcase}%").paginate(page: params[:page], per_page: 2)
    # else
    #   @products = Product.all.paginate(page: params[:page], per_page: 2)
    #   # @categories = Category.all
    # end 
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.friendly.find(params[:id])
    # @product_count = CartItem.where(product_id: @product.id)
    @reviews = @product.rating_reviews.to_a
    @avg_rating = if @reviews.blank?
      0
    else
      @product.rating_reviews.average(:rating).round(2)
    end

  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :full_price, :image, :category_id)
    end
end

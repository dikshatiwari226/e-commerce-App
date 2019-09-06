class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def product_details
   @product = Product.find(params[:id])
  end

  def all_product
    @products = Product.all.paginate(page: params[:page], per_page: 2)
  end

  def add_wishlist
    @product = Product.friendly.find(params[:product_id])
    if user_signed_in?
      existing_wishlist = current_user.wishlists.where(product_id: @product.id)
      if existing_wishlist.present?
        flash[:notice] = "Product is already into your wishlist"
        redirect_to root_path
      else
        current_user.wishlists.create(product_id: @product.id)
        flash[:notice] = "Product has been added into your wishlist"
        redirect_to root_path
      end
    else
      flash[:notice] = "You need to sign_in or sign_up"
      redirect_to "/users/sign_in"
    end
  end

  def add_to_cart
    @product = Product.friendly.find(params[:product_id])
    if user_signed_in?
      existing_cart = current_user.carts.where(product_id: @product.id)
      if existing_cart.present?
        flash[:notice] = "Product is already into your cart"
        redirect_to root_path
      else
        current_user.carts.create(product_id: @product.id)
        flash[:notice] = "Product has been added into your cart"
        redirect_to root_path
      end
    else
      flash[:notice] = "You need to sign_in or sign_up"
      redirect_to "/users/sign_in"
    end
  end

  def remove_wishlist
    @product = Product.friendly.find(params[:id])
    @remove_wishlist = current_user.wishlists.where(product_id: @product.id).first.destroy
    redirect_to "/wishlist"
  end

  def wishlist
    product_ids = current_user.wishlists.map(&:product_id)
    @products = Product.where(id: product_ids)
  end

  def cart
    cart_ids = current_user.carts.map(&:product_id)
    @products = Product.where(id: cart_ids)
  end

  def remove_cart
    @product = Product.friendly.find(params[:id])
    @remove_cart = current_user.carts.where(product_id: @product.id).first.destroy
    redirect_to "/cart"
  end

  # GET /products
  # GET /products.json
  def index
    if params[:id].present?
      @category = Category.find(params[:id])
      @products_all = @category.products.paginate(page: params[:page], per_page: 2)
    elsif 
      if params[:search].present?
      @products_all = Product.where("lower(name) LIKE :prefix OR lower(name) LIKE :prefix", prefix: "%#{params[:search].downcase}%").paginate(page: params[:page], per_page: 2)
      end
    else
      @products_all = Product.all.paginate(page: params[:page], per_page: 2)
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

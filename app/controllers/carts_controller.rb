class CartsController < ApplicationController

  def update_cart_item_quantity
      cart_item = CartItem.find(params[:cart_item_id])
      if params[:type] == "increase"
      	cart_item.update(quantity: cart_item.quantity + 1)
      	cart_item.price = cart_item.quantity * cart_item.unit_price
      	cart_item.save
      elsif params[:type] == "decrease" && cart_item.quantity != 1
      	cart_item.update(quantity: cart_item.quantity - 1)
          cart_item.price = cart_item.quantity * cart_item.unit_price
      	cart_item.save
      end
  end

   def add_to_cart
    @product = Product.find(params[:product_id])
    if @product
      if user_signed_in?
        if current_cart.present?
          cart_item = current_cart.cart_items.find_by_product_id(@product.id)
          if cart_item.blank?
            cart_item = current_cart.cart_items.new(product_id: @product.id)
          end
          cart_item.unit_price = @product.price
          cart_item.price = cart_item.unit_price * cart_item.quantity
          if (cart_item.save)
            flash[:notice] = "Product has been added into your cart"
            redirect_to root_path
          end
        else
        end
      else
        flash[:notice] = "you need to sign in or sign up"
        redirect_to "/users/sign_in"
      end
    end
  end


   def add_wishlist
    @product = Product.friendly.find(params[:product_id])
    if user_signed_in?
      existing_wishlist = current_user.wishlists.where(product_id: @product.id).uniq
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
  


  def remove_cart
    current_cart.cart_items.find(params[:id]).destroy
    flash[:notice] = "Cart Item was successfully removed."
    redirect_to "/cart"
  end

  def remove_wishlist
    @product =  Product.unscoped.friendly.find(params[:id])
    @remove_wishlist = current_user.wishlists.where(product_id: @product.id).first.destroy
    flash[:notice] = "Wishlist Item was successfully removed."
    redirect_to "/wishlist"
  end

  def wishlist
    if current_user.present?
      product_ids = current_user.wishlists.map(&:product_id)
      @products = Product.where(id: product_ids)
    
      current_user.wishlists.each do |wishlist|
        if wishlist.product.nil?
          wishlist.destroy!
        end
    end
    else
      redirect_to new_user_session_path
    end 
  end

  def cart
    if current_user.present?
      current_cart.cart_items.each do |cart_item|
        if cart_item.product.nil?
          cart_item.destroy!
        end
      end
    else
      redirect_to new_user_session_path
    end
  end

end
class OrdersController < ApplicationController

		# ===== User Profile =====
		def user_profile
		end

		# ======= billing address ====
		# def billing_address
		# 	@order = Order.all
		# end

		def new
			
		end

		def all_order_show
			@user = current_user
			@order = Order.create!(user_id: @user.id, cart_id: params[:cart_id], stripe_token: params[:stripeToken], stripe_token_type: params[:stripeTokenType], stripe_email: params[:stripeEmail])
			if @order.save!
					UserMailer.welcome_email(@user).deliver
					redirect_back fallback_location: charges_path, notice: "Order completed successfull"
			else
				render :new
			end
			# 	@products.each do |p|
			# 		@order = Order.create!(total: @product, user_id: @user.id, product_id: p)
			# 	end	
			# end	


			
				# redirect_back fallback_location: create_path
			# redirect_to orders_history_path	
		end

		def index
			# byebug
			if current_user.present?
				@orders = current_user.orders.last
				@cart = @orders.cart
				@cart_items = @cart.cart_items
			else
				redirect_to new_user_session_path
			end
			# @order_items = OrderItem.all
		end

		private
		def order_params
	    params.require(:order).permit(:user_id, :cart_id, :total, :status)
	  end
end

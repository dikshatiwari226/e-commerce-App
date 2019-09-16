class OrdersController < ApplicationController

		# ===== User Profile =====
		def user_profile
		end

		
		

		def new
			
		end

		def all_order_show
			@amount = current_cart.sub_total.to_i
	    customer = Stripe::Customer.create({
	      email: params[:stripeEmail],
	      source: params[:stripeToken],
	    })
	    charge = Stripe::Charge.create({
	      customer: customer.id,
	      amount: @amount,
	      description: 'Rails Stripe customer',
	      currency: 'usd',
	    })
			# rescue Stripe::CardError => e
    	# 	flash[:error] = e.message

			@user = current_user
			@order = Order.create!(user_id: @user.id, cart_id: current_cart.id, total: current_cart.sub_total, stripe_token: params[:stripeToken], stripe_token_type: params[:stripeTokenType], stripe_email: params[:stripeEmail])
			current_cart.update(is_done: true)
			# if @order.save!
					UserMailer.welcome_email(@user).deliver
					redirect_back fallback_location: charges_new_path, notice: "Order completed successfull"
			# else
				# render :new
			# end
		end

		def index
			# byebug
			@orders = Order.all.where(user_id: current_user.id)
			# if current_user.present?
			# 	 @user = current_user
   #      @cart = Cart.find_by(user_id: @user.id, is_done: false)
			# 	# @cart_id = current_user.orders.map(&:cart_id).first
			# 	# # @orders = current_user.orders.first
			# 	# # @cart = @orders.cart
			# 	# # @cart_items = @cart.cart_items
			# 	# cart = Cart.find_by(id: @cart_id, is_done: false)
			# 	@cart_items = @cart.cart_items
			# else
			# 	redirect_to new_user_session_path
			# end
			# @order_items = OrderItem.all
		end

		private
		def order_params
	    params.require(:order).permit(:user_id, :cart_id, :total, :status)
	  end
end

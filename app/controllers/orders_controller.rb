class OrdersController < ApplicationController

		# User Profile
		def user_profile
		end

		def new
			
		end

		def all_order_show
			# @product = params[:count]
			@user = current_user
			@order = Order.create!(quantity: params[:quantity], user_id: @user.id, product_id: params[:product_id], stripe_token: params[:stripeToken], stripe_token_type: params[:stripeTokenType], stripe_email: params[:stripeEmail])
			if @order.save!
					UserMailer.welcome_email(@user).deliver
					redirect_back fallback_location: charges_path, notice: "Order completed successfull"
					# redirect_to :back, notice: "Order completed successfull"
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
			if current_user.present?
				@orders = current_user.orders
			else
				redirect_to new_user_session_path
			end
			# @order_items = OrderItem.all
		end

		private
		def order_params
	    params.require(:order).permit(:user_id, :product_id, :cart_id, :total, :status, :quantity)
	  end
end

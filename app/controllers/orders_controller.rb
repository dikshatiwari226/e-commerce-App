class OrdersController < ApplicationController

		# User Profile
		def user_profile
		end

		def new
			
		end

		def all_order_show
			# @product = params[:count]
			byebug
			@user = current_user
			@order = Order.create!(quantity: params[:quantity], user_id: @user.id, product_id: params[:product_id])
			# if params[:product_id].present?
			# 	@products.each do |p|
			# 		@order = Order.create!(total: @product, user_id: @user.id, product_id: p)
			# 	end	
			# end	


			
				# redirect_back fallback_location: create_path
			redirect_to orders_history_path	
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

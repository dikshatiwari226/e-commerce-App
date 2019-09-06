class OrdersController < ApplicationController

	def new
		
	end

	def all_order_show
		@product = params[:count]
		@user = current_user
		@order = Order.create!(total: @product, user_id: @user.id)
			redirect_back fallback_location: root_path	
		
	end

	

	def index
		@orders = current_user.orders
		# @order_items = OrderItem.all
	end

	private
	def order_params
    params.require(:order).permit(:user_id, :product_id, :cart_id, :total, :status)
  end
end

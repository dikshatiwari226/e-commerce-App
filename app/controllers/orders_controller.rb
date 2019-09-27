class OrdersController < ApplicationController

		# ===== User Profile =====

		def user_profile
		end
		

		def order_delivery_report
			@delivery_report = Order.all
			
			# @line_chart_data = @delivery_report.map{ |order| {name: order.user.name, data: order.group_by_day(:created_at).count}}
		end

		def order_review
			@product = Product.unscoped.find(params[:id])
			@reviews = @product.rating_reviews.to_a
    	@avg_rating = if @reviews.blank?
      	0
    	else
   	 	@product.rating_reviews.average(:rating).round(2) rescue nil
    	end
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
			@order = Order.create!(user_id: @user.id, address_id:  params[:address_id], cart_id: current_cart.id, total: current_cart.sub_total, stripe_token: params[:stripeToken], stripe_token_type: params[:stripeTokenType], stripe_email: params[:stripeEmail])
			current_cart.update(is_done: true)
					# UserMailer.welcome_email(@user).deliver
					redirect_to orders_history_path
					flash[:notice] = "Order successfully completed"
		end

		def order_pdf
			@orders = current_user.orders
			respond_to do |format|
	      format.html
	      format.pdf do
	        render pdf: "order_pdf",     # Excluding ".pdf" extension.
	               show_as_html: params.key?("debug"),  # allow debugging based on url param
	               disable_smart_shrinking: true,
	               zoom: 0.75
	      	end
	      end
		end


		def index
			@orders = Order.unscoped.where(user_id: current_user.id).order("created_at desc").paginate(page: params[:page], per_page: 4)
    end
			
		private
		def order_params
	    params.require(:order).permit(:user_id, :cart_id, :total, :status)
	  end

end

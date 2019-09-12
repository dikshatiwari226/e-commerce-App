class ChargesController < ApplicationController
	def new
    
	end

  def create
    # Amount in cents
    # byebug
    @amount = 500

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

  rescue Stripe::CardError => e
    flash[:error] = e.message
    # redirect_to root_path
    redirect_to orders_history_path 

  end

  def show
    
  end


end

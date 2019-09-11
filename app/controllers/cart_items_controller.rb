class CartItemsController < ApplicationController

	belongs_to :product
	belongs_to :cart
	belongs_to :order

	# def total_price
	# 	price = unit_price * quantity
	# end
end

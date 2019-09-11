class CartItem < ApplicationRecord
	belongs_to :cart
	belongs_to :product
	# == Logic ====
	 
	# def total_price
	# 	price = unit_price * quantity
	# end
end

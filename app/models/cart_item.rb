class CartItem < ApplicationRecord
	belongs_to :cart
	belongs_to :product
	# has_many :orders

	default_scope {order(:created_at)}

	# # == Logic ====
	 
	# def total_price
	# 	unit_price = price * quantity
	# end
end

class OrderItem < ApplicationRecord
	belongs_to :product
	belongs_to :order

	def full_price_of_order_items
		price * quantity
	end
end

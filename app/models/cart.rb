class Cart < ApplicationRecord
	# belongs_to :product
	belongs_to :user
	has_many :cart_items
	has_many :orders

	# ==== sub total logic =====
	# def sub_total
	# 	sum = 0
	# 	self.cart_items.each do |cart_item|
	# 		sum+= cart_item.total_price
	# 	end
	# 	return sum 
	# end
end

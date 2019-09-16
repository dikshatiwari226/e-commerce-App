class Cart < ApplicationRecord
	# belongs_to :product
	belongs_to :user
	has_many :cart_items
	has_many :orders

	# logic ===
	# def cart_item_total_price
	# 	cart_item.to_a_sum = { |item| item.total_price }
	# end

	# ==== sub total logic =====
	def sub_total
		# byebug
		# cart_items.map(&:price).sum
		cart_items.map(&:price).reject {|e| !e.present?}.sum
	end

	def quantity
		cart_items.map(&:quantity).sum
	end
end

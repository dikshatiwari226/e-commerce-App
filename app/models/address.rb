class Address < ApplicationRecord
	belongs_to :user

	def full_address
		"#{address} #{district} #{country}, #{post_code}"
	end
end

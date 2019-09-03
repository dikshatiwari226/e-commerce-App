class Product < ApplicationRecord
	belongs_to :category

	mount_uploader :image, ImageUploader

	# FriendlyId 
  extend FriendlyId
  friendly_id :name, use: :slugged

end

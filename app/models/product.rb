class Product < ApplicationRecord

  #====== For Soft delete
  acts_as_paranoid
  
	belongs_to :category
  belongs_to :user,  optional: true
  has_many :rating_reviews, dependent: :destroy
  has_many :users, through: :rating_reviews, dependent: :destroy
  # belongs_to :order, optional: true
  # has_many :orders
  has_many :order_items, dependent: :destroy
  
	# For Image Upload
	mount_uploader :image, ImageUploader

	# FriendlyId 
  extend FriendlyId
  friendly_id :name, use: :slugged

  

  def display_price
  	result = ""
  	if self.price.to_f > 0
  		result += "#{self.price.to_i}"
  	end
  	return result
  end

  def display_full_price
  	result = ""
  	if self.full_price.to_f > 0
  		result += "#{self.full_price.to_i}"
  	end
  	return result
  end

  # Discount Percentage

  def discount_percentage
  	if price.present? && price > 0 && full_price.present? && full_price > 0
  		" " + (100 - (price.to_f / full_price.to_f * 100.0)).to_s + "%"
  	else
  		nil
  	end
  end



end

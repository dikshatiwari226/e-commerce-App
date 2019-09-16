class Category < ApplicationRecord
	has_many :products, dependent: :destroy

# ======= For friendly Id
 	extend FriendlyId
  friendly_id :name, use: :slugged
end

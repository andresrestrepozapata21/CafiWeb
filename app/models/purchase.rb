class Purchase < ApplicationRecord
	resourcify
	belongs_to :user
	has_many :purchase_products
 	has_many :products, through: :purchase_products
end

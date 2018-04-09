class Product < ApplicationRecord
	resourcify
	has_many :purchase_products
 	has_many :purchases, through: :purchase_products
end

class Purchase < ApplicationRecord
	resourcify
	belongs_to :user
	has_many :purchase_products
	has_many :products, through: :purchase_products
	has_attached_file :invoice, styles: { medium: "300x300>", thumb: "100x100>" } 
	validates_attachment_content_type :invoice, content_type: /\Aimage\/.*\z/
	validates :price, :presence => {:message => "El precio no puede estar en blanco" }
	validates :price, inclusion: { in: 0..100000000000 }
end

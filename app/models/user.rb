class User < ApplicationRecord
	rolify
	after_create :assign_default_role
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	has_many :purchases, dependent: :destroy

	def assign_default_role
		self.add_role(:client) if self.roles.blank?
	end

	validates :name, :presence => {:message => "El nombre no puede estar en blanco" }
 	validates_format_of :name, :with => /\A[a-zA-Z]*$\z/ , :message => 'solo acepta letras' 

	validates :document, :presence => {:message => "El documento no puede estar en blanco" }
	validates_format_of :document, :with => /\A[0-9]*$\z/ , :message => 'solo acepta numeros'

	validates :phone, :presence => {:message => "El telefono no puede estar en blanco" }
	validates_format_of :phone, :with => /\A[0-9]*$\z/ , :message => 'solo acepta numeros'

	validates :address, :presence => {:message => "El la direccion no puede estar en blanco" }

	validates :max_money, :presence => {:message => "El monto maximo no puede estar en blanco" }
	validates :max_money, inclusion: { in: 0..100000000000 }

 	validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i


	scope :search_user_by_email, ->(data) { where("email like ?", data).take}
	scope :sum_purchases_of_user_by_email, ->(data) { joins(:purchases).where("email like ?", data).sum(:price)}
end

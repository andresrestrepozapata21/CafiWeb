class User < ApplicationRecord
	rolify
	after_create :assign_default_role
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
	     :recoverable, :rememberable, :trackable, :validatable

	has_many :purchases 

	def assign_default_role
		self.add_role(:client) if self.roles.blank?
	end

	scope :search_user_by_email, ->(data) { where("email like ?", data).take}
end

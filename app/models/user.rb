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

	scope :search_user_by_email, ->(data) { where("email like ?", data).take}
	scope :sum_purchases_of_user_by_email, ->(data) { joins(:purchases).where("email like ?", data).sum(:price)}
end

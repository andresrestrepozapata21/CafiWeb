require 'rails_helper'

RSpec.feature "pruebas para login" do
	before :each do
		#p=Purchase.create!(:id => 1, :price => 1234, :time => "2018-04-17")
		u=User.create!(:id => 1, :document => "1234567", :name => "john",:phone => "1234567", :address => "cra 67", :email => "jcosoriov@uqvirtual.edu.co", :password => "123456")
		u.add_role "admin"
	end
	
	scenario "crear compra" do
		visit new_user_session_path

		fill_in "user[email]", with: "jcosoriov@uqvirtual.edu.co"
		fill_in "user[password]", with: "123456"

		click_on("iniciar Sesión")

		click_on("New Purchase")

		expect(page).to have_content("New Purchase")
		fill_in "client", with: "jcosoriov@uqvirtual.edu.co"
		fill_in "purchase[price]", with: 1234

		click_on("Create Purchase")
	end

end
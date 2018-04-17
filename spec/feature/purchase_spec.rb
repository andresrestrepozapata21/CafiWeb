require 'rails_helper'

RSpec.feature "pruebas para login" do
	before :each do
		p=Purchase.create!(:id => 1, :price => 1234, :time => "john",:phone => "1234567", :address => "cra 67", :email => "jcosoriov@uqvirtual.edu.co", :password => "123456")
		u=User.create!(:id => 1, :document => "1234567", :name => "john",:phone => "1234567", :address => "cra 67", :email => "jcosoriov@uqvirtual.edu.co", :password => "123456")
	end
	
	scenario "crear compra" do
		visit new_user_session_path

		fill_in "user[email]", with: "jcosoriov@uqvirtual.edu.co"
		fill_in "user[password]", with: "123456"

		click_on("iniciar Sesión")

		expect(page).to have_current_path(root_path)

		attach_file('Image', '/path/to/image.jpg')
	end

	scenario "inicio de sesion de administrador fallido" do
		visit new_user_session_path

		fill_in "user[email]", with: "jcosoriov@uqvirtual.edu.co"
		fill_in "user[password]", with: "1236"

		click_on("iniciar Sesión")
		expect(page).to have_current_path(new_user_session_path)
	end

	scenario "registro de usuario" do
		visit new_user_registration_path

		fill_in "user[name]", with: "john"
		fill_in "user[email]", with: "jcosoriov@uqvirtual.edu.co"
		fill_in "user[password]", with: "123456"
		fill_in "user[password_confirmation]", with: "123456"

		click_on("Registrarse")

		expect(page).to have_current_path(users_path)
	end

	scenario "registro de usuario fallido" do
		visit new_user_registration_path

		fill_in "user[name]", with: "john"
		fill_in "user[email]", with: "jcosoriov@uqvirtual.edu.co"
		fill_in "user[password]", with: "123456"
		fill_in "user[password_confirmation]", with: "1236"

		click_on("Registrarse")
		expect(page).to have_current_path(users_path)
	end
end
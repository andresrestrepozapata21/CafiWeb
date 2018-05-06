json.users do
	json.array!(@users) do |user|
		json.email user.email
		json.url users_path(client: user)
	end
end

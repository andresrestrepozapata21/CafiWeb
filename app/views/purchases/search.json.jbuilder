json.users do
	json.array!(@users) do |user|
		json.email user.email
		json.url user_path(user)
	end
end

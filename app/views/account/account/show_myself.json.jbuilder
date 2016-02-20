json.array!(@userArray) do |myself|
	json.extract! myself, :username, :user_token, :user_identifier, :icon_image_url
end

json.array!(@userArray) do |account|
	json.extract! account.user, :user_token, :username, :user_identifier, :icon_image_url
	json.extract! account, :follow_state, :following_count, :follower_count
end

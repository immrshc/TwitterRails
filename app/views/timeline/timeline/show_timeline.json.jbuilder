json.array!(@timeLineArray) do |timeLine|
	json.post timeLine.post, :post_token, :text, :latitude, :longitude, :image_width, :image_height
	json.user timeLine.post.user, :icon_image_url, :username, :user_identifier
	json.extract! timeLine, :favorite_state, :favorite_count, :image_url
end

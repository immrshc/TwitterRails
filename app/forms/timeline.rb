class Timeline
	include ActiveModel::Model

	attr_accessor :post
	attr_accessor :user
	attr_accessor :image_url
	attr_accessor :favorite_state
	attr_accessor :favorite_count
	attr_accessor :retweet_state
	attr_accessor :retweet_count

	def initialize(post, user)
		@post = post
		@user = user

		if post.image_key then
			@image_url = "http://localhost:3000/post/download/image?post[id]=#{post.id}"
		else
			@image_url = ""
		end

		@favorite_state = Favorite.where(user_id: user.id, post_id: post.id).exists?
		@favorite_count = Favorite.where(post_id: post.id).count
		@retweet_state = Retweet.where(user_id: user.id, post_id: post.id).exists?
		@retweet_count = Retweet.where(post_id: post.id).count 
	end
end

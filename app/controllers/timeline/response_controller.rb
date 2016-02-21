class Timeline::ResponseController < ApplicationController
	
	protect_from_forgery :except => [:favorite_add, :retweet_add, :favorite_subtract, :retweet_subtract]	
	
	def favorite_add
		user = User.find_by(user_params)
		post = Post.find_by(post_params)
		favorite = Favorite.new(user_id: user.id, post_id: post.id)
		if favorite.save then
			@result = true
		else
			@result = false
		end
	end

	def retweet_add
		user = User.find_by(user_params)
		post = Post.find_by(post_params)
		retweet = Retweet.new(user_id: user.id, post_id: post.id)
		if retweet.save then
			@result = true
		else
			@result = false
		end
	end

	def favorite_subtract
		user = User.find_by(user_params)
		post = Post.find_by(post_params)
		favorite =  Favorite.find_by(user_id: user.id, post_id: post.id)
		if favorite then
			if favorite.destroy then
				@result = true
			else
				@result = false
			end
		else
			@result = false
		end
	end

	def retweet_subtract
		user = User.find_by(user_params)
		post = Post.find_by(post_params)
		retweet =  Retweet.find_by(user_id: user.id, post_id: post.id)
		if retweet then
			if retweet.destroy then
				@result = true
			else
				@result = false
			end
		else
			@result = false
		end
	end

	def user_params
		params.require(:user).permit(:user_token, :user_identifier)
	end

	def post_params
		params.require(:post).permit(:post_token)
	end

end

class Account::RelationshipController < ApplicationController
	
	protect_from_forgery :except => [:show_myself, :show_following, :show_follower]

	def following_add
		following_user = User.find_by(user_token: user_params[:following_token])
		follower_user = User.find_by(user_token: user_params[:follower_token])
		relationship = Relationship.new(following_id: following_user.id, follower_id: follower_user.id)
		if relationship.save then
			@result = true
		else
			@result = false
		end
	end

	def following_subtract
		following_user = User.find_by(user_token: user_params[:following_token])
		follower_user = User.find_by(user_token: user_params[:follower_token])
		relationship = Relationship.find_by(following_id: following_user.id, follower_id: follower_user.id)
		if relationship then
			if relationship.destroy then
				@result = true
			else
				@result = false
			end
		else
			@result = false
		end
	end

	def user_params
		params.require(:user).permit(:follower_token, :following_token)
	end

end

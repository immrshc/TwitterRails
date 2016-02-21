class Account::AccountController < ApplicationController
	
	protect_from_forgery :except => [:show_myself, :show_following, :show_follower]

	def show_myself
		userArray = []
		user = User.find_by(user_params)
		if user then
			@userArray = userArray.push Account.new(user, user)
		end
	end

	def show_following
		userArray = []
		user = User.find_by(user_params)
		if user then
			Relationship.where(follower_id: user.id).each do |relationship|
				userArray.push Account.new(relationship.following, user)
			end
			@userArray = userArray.reverse
		end
	end

	def show_follower
		userArray = []
		user = User.find_by(user_params)
		if user then
			Relationship.where(following_id: user.id).each do |relationship|
				userArray.push Account.new(relationship.follower, user)
			end
			@userArray = userArray.reverse
		end
	end

	def user_params
		params.require(:user).permit(:user_token)
	end

end

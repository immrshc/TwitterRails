class Timeline::TimelineController < ApplicationController
	protect_from_forgery :except => [:show_timeline, :show_mypost, :show_myfavorite]
	def test
		#ユーザ1がリツイートした投稿
		#render json: Retweet.find_by(user_id: 1).post
		#投稿3へのリプライ
		#render json: Post.where(reply_id: 3)
		#ユーザ1がフォローしているユーザ
		#array = []
		#Relationship.where(follower_id: 1).each do |relationsip|
		#	array.push relationsip.followed
		#end
		#render json: array
	end


	def show_timeline
		user = User.find_by(user_params)
		#user = User.find_by(id: 1)
		timeLineArray = []
		if user then
			Relationship.where(follower_id: user.id).each do |relationsip|
				Post.where(user_id: relationsip.followed.id).each do |post|
					timeLineArray.push Timeline.new(post, user)
				end
			end
		end
		logger.debug("===============================")
		logger.debug(timeLineArray)
		@timeLineArray = timeLineArray.reverse
	end

	def show_mypost

	end

	def show_myfavorite

	end

	private 
	def user_params
		params.require(:user).permit(:user_token, :user_identifier)
	end

end

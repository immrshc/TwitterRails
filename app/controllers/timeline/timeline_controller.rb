class Timeline::TimelineController < ApplicationController
	protect_from_forgery :except => [:show_timeline, :show_geography, :show_reply, :show_mypost, :show_myfavorite]

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

	def show_timeline
		user = User.find_by(user_params)
		timeLineArray = []
		if user then

			#自分のフォローしているユーザの投稿を追加する
			Relationship.where(follower_id: user.id).each do |relationsip|
				Post.where(user_id: relationsip.following.id).each do |post|
					timeLineArray.push Timeline.new(post, user)
				end
			end
		
			#自分の投稿を追加する
			Post.where(user_id: user.id).each do |mypost|
				timeLineArray.push Timeline.new(mypost, user)
			end
			
			#自分がリツイートした投稿を追加する
			if Retweet.where(user_id: user.id).exists? then 
				Retweet.where(user_id: user.id).each do |retweet|
					timeLineArray.push Timeline.new(retweet.post, user)
				end
			end
			#作成時順にソートする
			timeLineArray.sort_by!{|t| t.post.created_at}
			@timeLineArray = timeLineArray.reverse
		
		end
	end
	
	def show_geography
		user = User.find_by(user_params)
		timeLineArray = []
		if user && map_params then
			posts = Timeline::Geography.new(map_params).get_near_posts
			if posts then
				posts.each do |post|
					timeLineArray.push Timeline.new(post, user)
				end
			end
			@timeLineArray = timeLineArray.reverse
		end
	end

	def show_reply
		post = Post.find_by(post_params)
		timeLineArray = []
		if post then
			Post.where(reply_id: post.id).each do |reply|
				timeLineArray.push Timeline.new(reply, post.user)
			end
		end

		timeLineArray.sort_by!{|t| t.post.created_at}
		@timeLineArray = timeLineArray
	end

	def show_mypost
		user = User.find_by(user_params)
		timeLineArray = []
		if user then
			Post.where(user_id: user.id).each do |mypost|
				timeLineArray.push Timeline.new(mypost, user)
			end
			

			#自分がリツイートした投稿を追加する
			if Retweet.where(user_id: user.id).exists? then
				Retweet.where(user_id: user.id).each do |retweet|
					timeLineArray.push Timeline.new(retweet.post, user)
				end
			end
			#作成時順にソートする
			timeLineArray.sort_by!{|t| t.post.created_at}
			@timeLineArray = timeLineArray.reverse
		
		end
	end

	def show_myfavorite
		user = User.find_by(user_params)
		timeLineArray = []
		if user then
			if Favorite.where(user_id: user.id).exists? then
				Favorite.where(user_id: user.id).each do |favorite|
					timeLineArray.push Timeline.new(favorite.post, user)
				end

				@timeLineArray = timeLineArray.reverse
			end
		end

	end
	
	private 
	def user_params
		params.require(:user).permit(:user_token, :user_identifier)
	end

	def post_params
		params.require(:post).permit(:post_token)
	end

	def map_params
		params.require(:map).permit(:latitude, :longitude)
	end

end

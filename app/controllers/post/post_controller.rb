class Post::PostController < ApplicationController
	protect_from_forgery :except => [:upload, :upload_with_image, :download_image]

	def upload
		user = User.find_by!(user_params)
		post = Post.new(post_params)
		post.user = userd

		if post.save then
			@result = true
		else
			@result = true
		end
	end

	def upload_with_image
		image = params[:image]
		post = Post.new(post_params)
		user = User.find_by!(user_params)
		post.user = user
		post.set_image(image)
			
		if post.save
			res = Post::AdministratorToAws.new.put_image(image, post.image_key)
			if res 
				@result = true
			else
				@result = false
			end
		end
	end

	def download_image
		post = Post.find_by(post_params)
		logger.debug('===========================')
		logger.debug(post.image_key)
		res =  Post::AdministratorToAws.new.get_image(post.image_key)
		send_data res.body.read, type: post.image_ctype, disposition: :inline
	end

	private 
	def post_params
		params.require(:post).permit(:id, :text, :latitude, :longitude)
	end

	def user_params
		params.require(:user).permit(:token)
	end

end

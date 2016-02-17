class PostController < ApplicationController
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
		post = save_post(image)
		if post
			res = Post::AwsAdministorator.put_image(image, post.image_key)
			if res 
				@result = true
			else
				@result = false
			end
		end
	end

	def download_image
		post = Post.find_by(post_params)
		res = Post::AwsAdministorator.get_image(post.image_key)
		send_data res.body.read, type: post.image_ctype, disposition: :inline
	end

	private 
	def post_params
		params.require(:post).permit(:id, :text, :latitude, :longitude)
	end

	def user_params
		params.require(:user).permit(:token)
	end
	
	def save_post(image)
		if file_invalid?(image)
			user = User.find_by!(user_params)
			post = Post.new(post_params)
			post.user = user
			post.image_key = "#{post.user.username}/Post/#{image.original_filename}"
			post.image_ctype = image.content_type
			if post.save
				post
			end
		end
	end

	def file_invalid?(image)
		ps = ['image/jpeg', 'image/jpg', 'image/gif', 'image/png']
		unless ps.include?(image.content_type) && image.size < 1.megabyte then
			logger.debug("画像のタイプ: #{image.content_type}, 容量: #{image.size}")
			false
		end
	end
end

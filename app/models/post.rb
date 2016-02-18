require 'fastimage'

class Post < ActiveRecord::Base
	has_many :posts
	belongs_to :user
	belongs_to :post, foreign_key: :reply_id
	validates :user_id, presence: true
	validates :post_token, presence: true, uniqueness: true
	validates :text, presence: true

	before_validation :set_token
	         
	def set_token 
		self.post_token = Digest::SHA1.hexdigest("#{self.id}#{rand.to_s}")[0..15]
	end

	def set_image(image)
		if file_invalid?(image)
			self.image_key = "#{self.user.username}/Post/#{image.original_filename}"
			self.image_ctype = image.content_type
			self.image_width = get_image_frame(image)[0]
			self.image_height = get_image_frame(image)[1]
		end
	end

	private
	def file_invalid?(image)
		ps = ['image/jpeg', 'image/jpg', 'image/gif', 'image/png']
		unless ps.include?(image.content_type) && image.size < 1.megabyte then
			logger.debug("画像のタイプ: #{image.content_type}, 容量: #{image.size}")
			false
		end
	end

	def get_image_frame(image)
    		FastImage.size(image.path)
    	end

end

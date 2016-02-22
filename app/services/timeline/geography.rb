class Timeline::Geography

	attr_accessor :latitude
	attr_accessor :longitude
	attr_accessor :min_latitude
	attr_accessor :max_latitude
	attr_accessor :min_longitude
	attr_accessor :max_longitude

	def initialize(args)
		@latitude = args[:latitude].to_f
		@longitude = args[:longitude].to_f
		self.set_range
	end

	def get_near_posts
		posts = Post.where(latitude: @min_latitude..@max_latitude, longitude: @min_longitude..@max_longitude)
	end

	def set_range
		@min_latitude = @latitude - 2.0
		@max_latitude = @latitude + 2.0
		@min_longitude = @longitude - 2.0
		@max_longitude = @longitude + 2.0
	end

end

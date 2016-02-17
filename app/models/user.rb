class User < ActiveRecord::Base
	
	has_many :relationships
	has_many :posts
	has_many :posts, through: :responses
	has_many :users, through: :relationships

	validates :user_token, presence: true, uniqueness: true
	validates :username, presence: true
	validates :hashed_password, presence: true
	validates :email, presence: true

	before_validation :set_token
	
	def set_token 
    		self.user_token = Digest::SHA1.hexdigest("#{self.id}#{rand.to_s}")[0..15]
  	end
	
	def password=(raw_password)
		if raw_password.kind_of?(String)
			self.hashed_password = BCrypt::Password.create(raw_password)
		elsif raw_password.nil?
			raise ArgumentError, 'パスワードが設定されていません'
		end
	end

end

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
end

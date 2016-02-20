class Response < ActiveRecord::Base
	
	belongs_to :user
	belongs_to :post

	validates :type, presence: true
	validates :user_id, presence: true
	validates :post_id, presence: true

	self.inheritance_column = :_type_disabled

end

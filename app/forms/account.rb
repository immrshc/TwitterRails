class Account
	include ActiveModel::Model

	attr_accessor :user
	attr_accessor :following_count
	attr_accessor :follower_count
	attr_accessor :follow_state

	def initialize(somebody, myself)
		@user = somebody
		@follower_count = Relationship.where(following_id: somebody.id).count
		@following_count = Relationship.where(follower_id: somebody.id).count
		@follow_state = Relationship.where(follower_id: myself.id, following_id: somebody.id).exists?
	end

end

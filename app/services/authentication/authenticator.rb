class Authentication::Authenticator
	
	def initialize(user)
		@user = user
	end

	def unique_user?
		if User.exists?(user_identifier: user.user_identifier) || User.exists?(hashed_password: user.hashed_password)
			return false
		else
			return true
		end
	end

end

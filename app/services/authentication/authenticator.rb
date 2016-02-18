class Authentication::Authenticator
	
	def absence_user?(args)
		if User.exists?(user_identifier: args[:user_identifier]) || User.exists?(hashed_password: args[hashed_password])
			return false
		else
			return true
		end
	end

	def valid_user(args)
		if user = User.find_by(user_identifier: args[:user_identifier])
			if BCrypt::Password.new(user.hashed_password) == args[:password]
				user	
			else
				false
			end
		else
			false
		end
	end

end

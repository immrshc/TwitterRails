class Authentication::Authenticator

	attr_accessor :user_identifier
	attr_accessor :password
	attr_accessor :username
	attr_accessor :email

	def unique_user?(args)
		
		@user_identifier ||= args[:user_identifier]
		@password ||= args[:password]
		@username ||= args[:username]
		@email ||= args[:email]
		
		#ユーザIDが固有で、ユーザ名、emailがnilでないかどうかを検証する
		unless User.exists?(user_identifier: @user_identifier) 
			if @username && @email
				user = User.new(user_identifier: @user_identifier, username: @username, email: @email)
				user.password = @password
				if user.save
					true
				else
					false
				end
			end
		else
			false
		end
	end

	def valid_user?(args)
		
		@user_identifier ||= args[:user_identifier]
		@password ||= args[:password]

		if user = User.find_by(user_identifier: @user_identifier)
			if BCrypt::Password.new(user.hashed_password) == @password
				user	
			else
				false
			end
		else
			false
		end
	end

end

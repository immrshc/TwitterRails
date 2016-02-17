class Authentication::SignUpController < ApplicationController
	protect_from_forgery :except => [:sign_up]
	def sign_up
		user = User.new(user_params)
		if Authentication::Authenticator.new(user).unique_user?
			@user = user
			@result = true
		else
			@result = false
		end
	end

	private
	def user_params
		params.require(:user).permit(:user_identifier, :password, :username, :email)
	end

end

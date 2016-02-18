class Authentication::SignInController < ApplicationController
    protect_from_forgery :except => [:sign_in]	
	def sign_in
		if user = Authentication::Authenticator.new.valid_user(user_params)
			@user = user
			@result = true
		else
			@result = false
		end
	end

	private
	def user_params
		params.require(:user).permit(:user_identifier, :password)
	end

end

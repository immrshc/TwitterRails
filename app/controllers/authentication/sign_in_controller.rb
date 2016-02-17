class Authentication::SignInController < ApplicationController
    protect_from_forgery :except => [:sign_in]	
	def sign_in
		if user = User.find_by(params[:user_identifier], hashed_password: BCrypt::Password.create(params[:password]))
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

class Authentication::SignUpController < ApplicationController
	protect_from_forgery :except => [:sign_up]

	def sign_up
		if Authentication::Authenticator.new.unique_user?(user_params)
			@user = User.find_by(user_identifier: user_params[:user_identifier])
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

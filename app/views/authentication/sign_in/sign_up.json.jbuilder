json.extract! @user, :user_token, :user_identifier, :username, :icon_image_url unless @user.nil?
json.result @result


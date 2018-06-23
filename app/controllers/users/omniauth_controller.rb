class Users::OmniauthController < ApplicationController

	def facebook
	 save_user_details
	end

	def google_oauth2
		save_user_details
	end

	def twitter
		save_user_details
	end

	def failure
	  flash[:error] = 'There was a problem signing you in. Please register or try signing in later.' 
	  redirect_to new_user_registration_url
	end

	private

	def save_user_details
	  @user = User.create_from_provider_data(request.env['omniauth.auth'])
	  if @user.persisted?
	    sign_in_and_redirect @user
	    # set_flash_message(:notice, :success) if is_navigational_format?
	  else
	    flash[:error] = 'There was a problem signing you in through Social media. Please register or try signing in later.'
	    redirect_to new_user_registration_url
	  end 
	end


end

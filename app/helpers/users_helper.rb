module UsersHelper
	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.email, class: "gravatar")
	end
	
	  # checks a user is logged in
   def logged_in_user
     unless logged_in?
       store_location
       flash[:danger] = "Please log in first!"
       redirect_to login_path
     end
   end
   
   # checks the correct user
   def correct_user
     @user = User.find(session[:user_id])
     redirect_to(root_url) unless current_user?(@user)
   end
   
   #updates times

end

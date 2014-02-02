class ApplicationController < ActionController::Base
  protect_from_forgery

  	

 	def user_admin
 	  unless current_user and current_user.admin?
		redirect_to home_path, :alert => "shaadi pe aya hai?" 
	  end
	end

	def current_level
	  return(Level.last ? Level.last.id : 0) if current_user.admin?
	  current_user.score
	end



end

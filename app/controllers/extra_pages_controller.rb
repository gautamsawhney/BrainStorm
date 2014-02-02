class ExtraPagesController < ApplicationController

   before_filter :user_admin, :only => [:admin]

   	def admin
   		@level = Level.new
   		@users = User.all
   	end

end

class AttemptsController < ApplicationController

def create 
	@attempt = current_user.attempts.build(params[:attempt])
	@attempt.level_id = current_level
	@level = Level.find(current_level)

	if @attempt.save
		if (@attempt.attempt).eql? (@level.answer)
			unless current_user.admin?
				current_user.score = @level.next_id
				current_user.save
			end

			flash[:success] = "Level Cleared"
			redirect_to level_path(current_level)
		
		else
			flash[:error] = "Wrong Answer"
			redirect_to level_path(current_level)
		end
	else
		@attempts = Attempt.find_all_by_user_id_and_level_id(current_user.id, @level.id)
		render 'levels/show'
	end

end

end
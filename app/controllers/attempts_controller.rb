class AttemptsController < ApplicationController
  before_filter :game_playable?, :only => [:create]

def create 
	@attempt = current_user.attempts.build(params[:attempt])
	@attempt.level_id = current_level
	@level = Level.find(current_level)


	if @attempt.save
		if sterlize(@attempt.attempt).eql? (@level.answer)
			unless current_user.admin?
				current_user.score = @level.next_id
				current_user.last_correct_answer_at = Time.now
				current_user.save
			end
			if (current_user.score == 6)
				redirect_to home_path
			    flash[:success] = "Congratulations YOU have completed the journey"
			else
			  flash[:success] = "Level Cleared"
			  redirect_to level_path(current_level)
			end		
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
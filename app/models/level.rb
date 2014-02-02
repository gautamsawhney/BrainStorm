class Level < ActiveRecord::Base
  attr_accessible :answer, :next_id, :prev_id, :question

  has_many :attempts

  def self.set(params)
  	next_id = nil
  	prev_id = (Level.last and Level.last.id) ? Level.last.id : nil
  	params[:prev_id] = prev_id
  	level = Level.new(params)
  	level
  end
end

class Image < ActiveRecord::Base
  attr_accessible :level_id, :image

  validates :image, :presence => true
  belongs_to :level
end

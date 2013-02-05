class ForumCategory < ActiveRecord::Base
  attr_accessible :position, :title

  has_many :forums

  validates :title, :presence => { :message => "* A title is required." }
  validates :title, :uniqueness => { :case_sensitive => false, :message => "* There is already a forum with this title." }

  default_scope order("position asc")
end

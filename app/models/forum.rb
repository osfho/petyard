class Forum < ActiveRecord::Base
  attr_accessible :accessibility, :description, :forum_category_id, :position, :title, :permalink
  
  belongs_to :forum_category
  has_many :topics

  validates :title, :presence => {:message => "* A title is required."}
  validates :title, :uniqueness => { :case_sensitive => false, :message => "* There is already a forum with this title." }

  default_scope order("position asc")

  def to_param
    permalink
  end

  def last_post
    last_topic = self.topics.first
    return last_topic.last_post if last_topic
  end
end

class Topic < ActiveRecord::Base
  attr_accessible :forum_id, :locked, :sticky, :title, :user_id

  belongs_to :user
  belongs_to :forum
  has_many :posts, :dependent => :destroy

  validates :title, :presence => { :message => "* Your topic must have a title." }

  default_scope order("latest_post_id desc")
  scope :notstickied, where(:sticky => false)
  scope :stickied, where(:sticky => true)

  def to_param
    permalink
  end

  def editable?
    Time.now < (created_at + 30.seconds) || Time.now < (updated_at + 30.seconds)
  end

  def last_post
    self.posts.last
  end

  def replies
    self.posts.count - 1
  end
end

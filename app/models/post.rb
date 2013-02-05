class Post < ActiveRecord::Base
  attr_accessible :body, :hidden, :op, :title, :topic_id, :user_id

  belongs_to :topic
  belongs_to :user
  has_one :mod_message, :dependent => :destroy

  validates :body, :presence => { :message => "* Your post cannot be blank." }

  def content
    if hidden
      "<em>The contents of this post have been hidden by a moderator.</em>"
    else
      self.body
    end
  end

  def quote
    "<blockquote><em>On <a href='/forums/#{self.topic.forum.permalink}/#{self.topic.permalink}##{self.id}'>#{self.posted}</a>, <a href='/profile/#{self.user.username}'>#{self.user.username}</a> said:</em><br /><br />#{self.content}</blockquote><br />"
  end

  def editable?
    Time.now < (created_at + 30.seconds) || Time.now < (updated_at + 30.seconds)
  end

  def posted
    created_at.strftime("%B %e, %Y at %l:%M %P (%Z)")
  end

end

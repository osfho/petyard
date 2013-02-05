module ApplicationHelper
  def day_class(time)
    if time > Time.now - 24.hours
      return "today"
    else
      if time > Time.now - 48.hours
        return "yesterday"
      else
        return "olderday"
      end
    end
  end

  def latest_forum_posts(amount = 5)
    topics = Topic.includes(:posts).order('latest_post_id asc').limit(amount)
    posts = []
    
    topics.each do |topic|
      posts << topic.posts.last
    end

    return posts.sort_by{|e| e[:created_at]}.reverse
  end

  def show_flash
    if flash[:success]
      return "<div id='flash' class='success'>#{flash[:success]}</div>"
    else
      if flash[:error]
        return "<div id='flash' class='error'>#{flash[:error]}</div>"
      end
    end
  end

  def can_access(power)
    logged_in? and current_user.has_power(power)
  end
  
  def can_edit(object)
    (logged_in? && current_user == object.user) || can_access(3)
  end
end

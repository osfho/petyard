class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_new_session, :get_current_users

  protected

  def prepare_new_session
    @user = User.new if current_user.blank?
  end

  def require_power(power)
    unless logged_in? and current_user.has_power(power)
      flash.now[:notice] = "You do not have access to this area.<br />If you believe this is an error, please contact an administrator.<br /><br /><a href='#{root_url}'>Continue to home page</a>"
      render 'home/notify'
      return false
    else
      return true
    end
  end

  def create_permalink(title)
    title.downcase.gsub(/\s+/, '-').gsub(/[^a-zA-Z0-9_-]+/, '')
  end

  def get_current_users
    @current_users = current_users
  end

  def get_players_online
    @server = Minequery.query("petyard.net")
    @server[:player_list] if @server
  end

end

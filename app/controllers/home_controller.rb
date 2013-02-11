class HomeController < ApplicationController
  include Minequery

  def index
    @page_id = 'home'
    @features = Feature.all

    @players_online = get_players_online
  end

  def notify
    unless notice
      redirect_to root_url
    end
  end

  def map
    @page_id = 'map'
  end

  def players_online
    @players_online = get_players_online
  end
end

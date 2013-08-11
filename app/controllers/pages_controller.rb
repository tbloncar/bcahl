class PagesController < ApplicationController
  def index
  	@active_seasons = Season.active
  	@players = Player.all
  	@photos = Photo.latest
  end

  def about
  end

  def contact
  end
end

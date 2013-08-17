class PagesController < ApplicationController

  def index
  	@active_seasons = Season.active
  	@players = Player.all
  	@photos = Photo.latest

  	@title = "BCAHL | Beaver County Adult Hockey League"
  end

  def about
  end

  def contact
  end
end

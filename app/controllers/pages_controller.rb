class PagesController < ApplicationController

  def index
  	@players = Player.all
  	@photos = Photo.latest
  	@upcoming_games = Game.upcoming
  	@recent_games = Game.recent


  	@title = "BCAHL | Beaver County Adult Hockey League"
  end

  def calendar
  	@events = Game.all
  	@date = params[:month] ? Date.parse(params[:month]) : Date.today
  end

  def about
  end

  def contact
  end
end

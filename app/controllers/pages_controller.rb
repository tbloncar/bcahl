class PagesController < ApplicationController
  def index
  	@active_seasons = Season.active
  	@players = Player.all
  end
end

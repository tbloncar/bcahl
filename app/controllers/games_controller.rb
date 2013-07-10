class GamesController < ApplicationController
	include SessionsHelper

	before_action :set_game, only: [:show, :edit, :update, :destroy]

  def new
  	if signed_in?
  		@game = Game.new
  		@season = Season.find_by(path: params[:season_path], league_id: League.find_by_path(params[:league_path]).id)
		else
			flash[:notice] = "You must be an administrator to access this page."
			redirect_to root_url
		end
  end

  def create
  	@game = Game.new(game_params)

		if @game.save
			flash[:success] = "New game successfully added."
			redirect_to game_url(@game.id)
		else
			@season = Season.find_by_id(game_params[:season_id])
			render 'new'
		end
  end

  def edit
  end

  def show
  end

  def update
  	if @game.update(game_params)
			flash[:success] = "Game successfully updated."
			redirect_to game_url(@game.id)
		else
			render 'edit'
		end
	end

	def destroy
		if @game.destroy
			flash[:success] = "Game successfully deleted."
			redirect_to root_url
		else
			flash[:notice] = "Hm. That didn't work as planned."
			redirect_to edit_game_url(@game.id)
		end
	end

  private
  	def game_params
  		params.require(:game).permit(:season_id, :date_and_time, :ot, :home_id, :away_id, :home_goals, :away_goals)
  	end

  	def set_game
  		@game = Game.find_by_id(params[:game_id])
  	end
end
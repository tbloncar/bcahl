class SeasonsController < ApplicationController
	include SessionsHelper

	before_action :set_season, only: [:show, :edit, :update, :destroy]

	def new
		if signed_in?
			@season = Season.new
		else
			flash[:notice] = "You must be an administrator to access this page."
			redirect_to root_url
		end
	end

	def create
		@season = Season.new(season_params)

		if @season.save
			flash[:success] = "New season successfully added."
			redirect_to season_url(@season.league.path, @season.path)
		else
			render 'new'
		end
	end

	def index
		@seasons = Season.all
	end

	def show

	end

	def edit
	end

	def update
		if @season.update(season_params)
			flash[:success] = "Season successfully updated."
			redirect_to season_url(@season.league.path, @season.path)
		else
			render 'edit'
		end
	end

	def destroy
		if @season.destroy
			flash[:success] = "Season successfully deleted."
			redirect_to root_url
		else
			flash[:notice] = "Hm. That didn't work as planned."
			redirect_to edit_season_url(@season.league.path, @season.path)
		end
	end

	private
		def season_params
      params.require(:season).permit(:name, :league_id)
    end

    def set_season
    	league_id = League.find_by(path: params[:league_path]).id
    	@season = Season.find_by(path: params[:season_path], league_id: league_id)
    end
end
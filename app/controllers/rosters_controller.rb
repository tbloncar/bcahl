class RostersController < ApplicationController
	include SessionsHelper

	before_action :set_roster, only: [ :show, :edit, :destroy ]

	def create
		@roster = Roster.new(season_id: params[:season_id])
		@roster.team_id = Team.find_by(name: params[:team_name]).try(:id)

		if @roster.team_id && @roster.save
			flash[:success] = "#{@roster.team.name} successfully added to #{@roster.season.league.name} - #{@roster.season.name}."
		end

		redirect_to edit_season_url(@roster.season.league.path, @roster.season.path)
	end

	def show
	end

	def edit
	end

	def destroy
		if @roster.destroy
			flash[:success] = "Roster successfully removed."
			redirect_to season_url(@roster.season.league.path, @roster.season.path)
		else
			flash[:notice] = "Hm. It looks like something went wrong."
			redirect_to roster_url(@roster.season.league.path, @roster.season.path, @roster.team.path)
		end
	end

	private
		def set_roster
			league 		= League.find_by(path: params[:league_path])
			season 		= Season.find_by(path: params[:season_path], league_id: league.id)
			team 			= Team.find_by(path: params[:roster_path])
			@roster 	= Roster.find_by(team_id: team.id, season_id: season.id)
		end
end

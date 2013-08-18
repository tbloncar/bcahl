class RostersController < ApplicationController
	include SessionsHelper

	before_action :set_roster, only: [ :show, :edit, :destroy ]
	before_action :set_robots, only: [:edit]

	def create
		@roster = Roster.new(season_id: params[:season_id])
		@roster.team_id = Team.find_by(name: params[:team_name]).try(:id)

		if @roster.team_id && @roster.save
			if @roster.team.has_rosters?
				@roster.team.rosters[-2].players.each do |player|
					RosterSpot.create(player_id: player.id, roster_id: @roster.id)
				end
			end
			flash[:success] = "#{@roster.team.name} (with #{@roster.players.count} players) successfully added to #{@roster.season.league.name} - #{@roster.season.name}."
		end

		redirect_to edit_season_url(@roster.season.league.path, @roster.season.path)
	end

	def show
		@title = "#{@roster.team_name_and_season_and_league} | BCAHL"
		@meta_description = "View scores and statistics: #{@roster.team_name_and_season_and_league}."
	end

	def edit
		@title = "Edit Roster"
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

		def set_robots
  		@robots = "noindex"
  	end
end

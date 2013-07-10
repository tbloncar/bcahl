class RosterSpotsController < ApplicationController
	def create
		@roster_spot = RosterSpot.new(roster_id: params[:roster_id])
		@roster_spot.player_id = Player.find_by(full_name: params[:player_name]).try(:id)

		if @roster_spot.player_id && @roster_spot.save
			flash[:success] = "#{@roster_spot.player.full_name} successfully added to #{@roster_spot.roster.team.name}."
		end
		redirect_to roster_url(@roster_spot.roster.season.league.path, @roster_spot.roster.season.path, @roster_spot.roster.team.path)
	end

	def destroy
	end
end
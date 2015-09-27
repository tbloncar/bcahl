class RosterSpotsController < ApplicationController
  def create
    @roster_spot = RosterSpot.new(roster_id: params[:roster_id])
    @roster_spot.player_id = Player.find_by(
      "f_name || ' ' || l_name = ?",
      params[:player_name]
    ).try(:id)

    if @roster_spot.player_id && @roster_spot.save
      flash[:success] = "#{@roster_spot.player.full_name} successfully added to #{@roster_spot.roster.team.name}."
    else
      flash[:notice] = "Hm. That player either already exists on this roster or is not in our system."
    end
    redirect_to edit_roster_url(@roster_spot.roster.season.league.path, @roster_spot.roster.season.path, @roster_spot.roster.team.path)
  end

  def destroy
    @roster_spot = RosterSpot.find_by_id(params[:id])

    if @roster_spot.destroy
      flash[:success] = "Player successfully removed from roster."
    end
    redirect_to edit_roster_url(@roster_spot.roster.season.league.path, @roster_spot.roster.season.path, @roster_spot.roster.team.path)
  end
end

class MembershipsController < ApplicationController
	def create
		@membership = Membership.new(team_id: params[:team_id])
		@membership.player_id = Player.find_by_full_name(params[:player_name]).try(:id)

		if @membership.player_id && @membership.save
			flash[:success] = "#{@membership.player.full_name} successfully added to #{@membership.team.name}."
		end
		redirect_to team_url(@membership.team.path)
	end

	def destroy
	end
end

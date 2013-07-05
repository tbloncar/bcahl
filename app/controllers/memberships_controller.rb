class MembershipsController < ApplicationController
	def create
		@membership = Membership.create(membership_params)

		if @membership.save
			flash[:success] = "#{@membership.player.full_name} successfully added to #{@membership.team.name}."
		else
			flash[:notice] = "Hm. Something didn't go as planned."
		end
		redirect_to player_url(@membership.player.path)
	end

	def destroy
	end

	private
		def membership_params
			params.require(:membership).permit(:team_id, :player_id, :captain)
		end
end

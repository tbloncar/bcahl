class TeamsController < ApplicationController
	include SessionsHelper
	include TeamsHelper

	before_action :set_team, only: [:show, :edit, :update, :destroy]
	before_action :set_colors, only: [:new, :edit]

	def new
		if signed_in?
			@team = Team.new
		else
			flash[:notice] = "You must be an administrator to access this page."
			redirect_to root_url
		end
	end

	def create
		@team = Team.new(team_params)

		if @team.save
			flash[:success] = "New team successfully added."
			redirect_to team_url(@team.path)
		else
			render 'new'
		end
	end

	def index
		@teams = Team.all
	end

	def show
		@membership = Membership.new
	end

	def edit
	end

	def update
		if @team.update(team_params)
			flash[:success] = "Team successfully updated."
			redirect_to team_url(@team.path)
		else
			render 'edit'
		end
	end

	def destroy
		if @team.destroy
			flash[:success] = "Team successfully deleted."
			redirect_to root_url
		else
			flash[:notice] = "Hm. That didn't work as planned."
			redirect_to edit_team_url(@team.path)
		end
	end

	private
		def team_params
      params.require(:team).permit(:name, :color)
    end

    def set_team
    	@team = Team.find_by_path(params[:path])
    end

    def set_colors
    	@colors = colors_array.map { |color| color.capitalize }
    end
end

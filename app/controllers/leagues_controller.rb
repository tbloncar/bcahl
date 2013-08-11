class LeaguesController < ApplicationController
	include SessionsHelper

	before_action :set_league, only: [:show, :edit, :update, :destroy]

	def new
		if signed_in?
			@league = League.new
		else
			flash[:notice] = "You must be an administrator to access this page."
			redirect_to root_url
		end
	end

	def create
		@league = League.new(league_params)

		if @league.save
			flash[:success] = "New league successfully added."
			redirect_to user_url(current_user.path)
		else
			render 'new'
		end
	end

	def index
		@leagues = League.all
	end

	def show

	end

	def edit
	end

	def update
		if @league.update(league_params)
			flash[:success] = "League successfully updated."
			redirect_to league_url(@league.path)
		else
			render 'edit'
		end
	end

	def destroy
		if @league.destroy
			flash[:success] = "League successfully deleted."
			redirect_to root_url
		else
			flash[:notice] = "Hm. That didn't work as planned."
			redirect_to edit_league_url(@league.path)
		end
	end

	private
		def league_params
      params.require(:league).permit(:name)
    end

    def set_league
    	@league = League.find_by_path(params[:path])
    end
end

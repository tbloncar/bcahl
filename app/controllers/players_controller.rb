class PlayersController < ApplicationController
	include SessionsHelper

	before_action :set_player, only: [:show, :update]

	def new
		if signed_in?
			@player = Player.new
		else
			flash[:notice] = "You must be an administrator to access this page."
			redirect_to root_url
		end
	end

	def create
		@player = Player.new(player_params)
		@player.path = @player.create_url_path

		if @player.save
			flash[:success] = "New player successfully added."
			redirect_to player_url(@player.path)
		else
			render 'new'
		end
	end

	def index
		@players = Player.all
	end

	def show
	end

	def update
	end

	def destroy
	end

	private
		def player_params
      params.require(:player).permit(:f_name, :l_name, :email)
    end

    def set_player
    	@player = Player.find_by_path(params[:path])
    end
end
class PlayersController < ApplicationController
	include SessionsHelper

	before_action :set_player, only: [:show, :edit, :update, :destroy]

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
		@players = Player.order(:f_name).where("f_name like ? OR l_name like ?", "%#{params[:term]}%", "%#{params[:term]}%")
		respond_to do |format|
			format.html
			format.json { render json: @players.map { |player| player.full_name }}
		end
	end

	def show
		@membership = Membership.new
	end

	def edit
	end

	def update
		if @player.update(player_params)
			flash[:success] = "Player successfully updated."
			redirect_to player_url(@player.path)
		else
			render 'edit'
		end
	end

	def destroy
		if @player.destroy
			flash[:success] = "Player successfully deleted."
			redirect_to root_url
		else
			flash[:notice] = "Hm. That didn't work as planned."
			redirect_to edit_player_url(@player.path)
		end
	end

	private
		def player_params
      params.require(:player).permit(:f_name, :l_name, :email)
    end

    def set_player
    	@player = Player.find_by_path(params[:path])
    end
end

class PlayersController < ApplicationController
  include SessionsHelper

  before_action :set_player, only: [:show, :edit, :update, :destroy]
  before_action :set_robots, only: [:new, :edit]

  def new
    if signed_in?
      @player = Player.new
    else
      flash[:notice] = "You must be an administrator to access this page."
      redirect_to root_url
    end

    @title = "New Player"
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      flash[:success] = "New player successfully added."
      redirect_to user_url(current_user.path)
    else
      flash[:notice] = "Hm. That player may already exist in our system."
      redirect_to new_player_url
    end
  end

  def index
    clause = "lower(f_name) like ? or lower(l_name) like ? "\
             "or lower(f_name) || ' ' || lower(l_name) like ?"
    @players = Player.order(:f_name).where(clause,
                                          "%#{params[:term].downcase}%",
                                          "%#{params[:term].downcase}%",
                                          "%#{params[:term].downcase}%")
    respond_to do |format|
      format.html
      format.json { render json: @players.map { |player| player.full_name }}
    end
  end

  def show
    @title = "#{@player.full_name} | Beaver County Adult Hockey League"
    @meta_description = "See game history and statistics for #{@player.full_name} in the BCAHL."
  end

  def edit
    @title = "Edit Player"
  end

  def update
    if @player.update(player_params)
      flash[:success] = "Player successfully updated."
      redirect_to user_url(current_user.path)
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

    def set_robots
      @robots = "noindex"
    end
end

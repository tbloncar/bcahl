class SeasonsController < ApplicationController
  include SessionsHelper

  before_action :set_season, only: [:show, :edit, :update, :activate, :destroy, :deactivate]
  before_action :set_robots, only: [:new, :edit]

  def new
    if signed_in?
      @season = Season.new
    else
      flash[:notice] = "You must be an administrator to access this page."
      redirect_to root_url
    end

    @title = "New Season"
  end

  def create
    @season = Season.new(season_params)

    if @season.save
      flash[:success] = "New season successfully added."
      redirect_to season_url(@season.league.path, @season.path)
    else
      render 'new'
    end
  end

  def index
    @seasons = Season.active

    @title = "Active Seasons | Beaver County Adult Hockey League"
    @meta_description = "View the active seasons in the Beaver County Adult Hockey League."
  end

  def show
    @title = "#{@season.name_with_league} | Beaver County Adult Hockey League"
    @meta_description = "View the schedule, standings, results, and rosters for #{@season.name_with_league}."
  end

  def edit
    @title = "Edit Season"
  end

  def update
    if @season.update(season_params)
      flash[:success] = "Season successfully updated."
      redirect_to season_url(@season.league.path, @season.path)
    else
      render 'edit'
    end
  end

  def activate
    @season.active = true
    if @season.save
      flash[:success] = "Season successfully activated."
      redirect_to edit_season_url(@season.league.path, @season.path)
    else
      render 'show'
    end
  end

  def deactivate
    @season.active = false
    if @season.save
      flash[:success] = "Season successfully deactivated."
      redirect_to edit_season_url(@season.league.path, @season.path)
    else
      render 'show'
    end
  end

  def destroy
    if @season.destroy
      flash[:success] = "Season successfully deleted."
      redirect_to root_url
    else
      flash[:notice] = "Hm. That didn't work as planned."
      redirect_to edit_season_url(@season.league.path, @season.path)
    end
  end

  private
    def season_params
      params.require(:season).permit(:name, :league_id)
    end

    def set_season
      league_id = League.find_by(path: params[:league_path]).id
      @season = Season.find_by(path: params[:season_path], league_id: league_id)
    end

    def set_robots
      @robots = "noindex"
    end
end
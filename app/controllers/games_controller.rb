class GamesController < ApplicationController
  include SessionsHelper

  before_action :set_game, only: [:show, :edit, :update,
    :destroy, :score, :update_score, :update_stats]
  before_action :set_robots, only: [:new, :edit, :score]

  def new
    if signed_in?
      @game = Game.new
      @season = Season.find_by(path: params[:season_path], league_id: League.find_by_path(params[:league_path]).id)
    else
      flash[:notice] = "You must be an administrator to access this page."
      redirect_to root_url
    end

    @title = "New Game"
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      Participation.create_records_for_game(@game)

      flash[:success] = "New game successfully added."
      redirect_to edit_season_url(@game.season.league.path, @game.season.path)
    else
      @season = Season.find_by_id(game_params[:season_id])
      render 'new'
    end
  end

  def edit
    @title = "Edit Game"
  end

  def show
    @title = "#{@game.name_and_date_and_time} | BCAHL"
    @meta_description = "#{@game.name_and_date_and_time} - Beaver County Adult Hockey League."
  end

  def update
    if @game.update(game_params)
      flash[:success] = "Game successfully updated."
      redirect_to edit_game_url(@game.id)
    else
      render 'edit'
    end
  end

  def score
    @title = "Score Game"
    @stats = Stats.new(@game)
  end

  def update_score
    old_home_goals = @game.home_goals || 0
    old_away_goals = @game.away_goals || 0
    old_ot = @game.ot
    if @game.update(game_params)
      @game.home_roster.save if @game.home_roster.update_stats(@game.home_goals, @game.away_goals, @game.ot, old_home_goals, old_away_goals, old_ot)
      @game.away_roster.save if @game.away_roster.update_stats(@game.away_goals, @game.home_goals, @game.ot, old_away_goals, old_home_goals, old_ot)
      flash[:success] = "Score added successfully."
      redirect_to edit_season_url(@game.season.league.path, @game.season.path)
    end
  end

  def update_stats
    if home_stats = stats_params[:home_stats_attributes]
      Participation.update_records(home_stats)
    end

    if away_stats = stats_params[:away_stats_attributes]
      Participation.update_records(away_stats)
    end

    redirect_to score_game_url(@game)
  end

  def destroy
    if @game.destroy
      flash[:success] = "Game successfully deleted."
      redirect_to edit_season_url(@game.season.league.path, @game.season.path)
    else
      flash[:notice] = "Hm. That didn't work as planned."
      redirect_to edit_game_url(@game.id)
    end
  end

  private
    def stats_params
      params.require(:stats).permit(home_stats_attributes: [
        :goals, :assists, :pim, :id
      ], away_stats_attributes: [
        :goals, :assists, :pim, :id
      ])
    end

    def game_params
      params.require(:game).permit(:season_id, :date_and_time,
                                   :ot, :home_id, :away_id,
                                   :home_goals, :away_goals, :time_tbd)
    end

    def set_game
      @game = Game.find_by_id(params[:game_id])
    end

    def set_robots
      @robots = "noindex"
    end
end

class Stats
  extend ActiveModel::Naming
  include ActiveModel::AttributeMethods

  def initialize(game)
    @game = game
    @home_stats = game.home_roster.participations_for_game(game)
    @away_stats = game.away_roster.participations_for_game(game)
  end

  def to_key
  end

  def home_stats
    @home_stats
  end

  def away_stats
    @away_stats
  end

  def home_stats_attributes=(attributes)
    puts attributes
  end

  def away_stats_attributes=(attributes)
    puts attributes
  end
end

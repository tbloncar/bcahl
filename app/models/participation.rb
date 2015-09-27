class Participation < ActiveRecord::Base
  validates :roster_spot, presence: true
  validates :game, presence: true
  validates :goals, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :assists, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :pim, numericality: { greater_than_or_equal_to: 0, only_integer: true }

  belongs_to :roster_spot
  belongs_to :game

  def self.create_records_for_game(game)
    spots = [*game.home_roster.roster_spots, *game.away_roster.roster_spots]

    spots.each do |spot|
      create(game: game, roster_spot: spot)
    end
  end

  def self.update_records(stats)
    stats.each do |k, stat|
      p = find(stat.delete("id"))
      p.update(stat)
    end
  end
end

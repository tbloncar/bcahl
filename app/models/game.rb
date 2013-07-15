class Game < ActiveRecord::Base
	belongs_to :season
	belongs_to :home_roster, class_name: 'Roster', foreign_key: 'home_id'
	belongs_to :away_roster, class_name: 'Roster', foreign_key: 'away_id'

	validates :date_and_time, uniqueness: { scope: :season_id, message: "should not be scheduled at the same time as other games." }
	validates :season_id, presence: true
	validates :home_id, numericality: true
	validates :away_id, numericality: true
	validate :home_and_away_cannot_be_same

	# validates :ot, presence: true

	default_scope -> { order(date_and_time: :asc) }

	def home_and_away_cannot_be_same
    if home_id == away_id
      errors.add(:away_id, "must be different.")
    end
  end

  def date
  	date_and_time.strftime("%m/%d/%y")
  end

  def time
  	date_and_time.strftime("%I:%M %p")
  end

  def home_team_name
  	home_roster.team.name
  end

  def away_team_name
  	away_roster.team.name
  end
end

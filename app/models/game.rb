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

	def home_and_away_cannot_be_same
    if home_id == away_id
      errors.add(:away_id, "must be different.")
    end
  end

end

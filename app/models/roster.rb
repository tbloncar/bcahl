class Roster < ActiveRecord::Base
	belongs_to :season
	belongs_to :team
	has_many :players, through: :roster_spots
	has_many :roster_spots, dependent: :destroy

	validates :team_id, uniqueness: { scope: :season_id }

	def games_played
		wins + losses + ot_losses
	end

	def points
		wins * 2 + ot_losses
	end

	def team_name
		team.name
	end
end

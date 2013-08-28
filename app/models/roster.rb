class Roster < ActiveRecord::Base
	belongs_to :season
	belongs_to :team
	has_many :players, through: :roster_spots
	has_many :roster_spots, dependent: :destroy
	has_many :home_games, class_name: "Game", foreign_key: "home_id"
	has_many :away_games, class_name: "Game", foreign_key: "away_id"

	validates :team_id, uniqueness: { scope: :season_id }

	scope :standings, -> { order(points: :desc) }

	def games_played
		wins + losses + ot_losses
	end

	def games
		home_games + away_games
	end

	def team_name
		team.name
	end

	def team_name_and_season_and_league
		"#{team_name} - #{season.name} - #{season.league.name}"
	end

	def add_points(points)
		self.points += points
	end

	def add_win
		self.wins += 1
		add_points(2)
	end

	def add_loss(ot)
		if ot
			self.ot_losses += 1
			add_points(1)
		else
			self.losses += 1
		end
	end

	def add_goals_for(goals)
		self.goals_for += goals
	end

	def add_goals_against(goals)
		self.goals_against += goals
	end

	def update_stats(goals_for, goals_against, ot)
		goals_for > goals_against ? add_win : add_loss(ot)
		add_goals_for(goals_for)
		add_goals_against(goals_against)
	end
end

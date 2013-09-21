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

	def add_tie
		self.ties += 1
		add_points(1)
	end

	def add_goals_for(goals)
		self.goals_for += goals
	end

	def add_goals_against(goals)
		self.goals_against += goals
	end

	def update_stats(goals_for, goals_against, ot, old_goals_for, old_goals_against, old_ot)
		remove_old_stats(old_goals_for, old_goals_against, old_ot)
		add_win if goals_for > goals_against
		add_loss(ot) if goals_against > goals_for
		add_tie if goals_for == goals_against
		add_goals_for(goals_for)
		add_goals_against(goals_against)
	end

	def remove_goals_for(goals)
		self.goals_for -= goals
	end

	def remove_goals_against(goals)
		self.goals_against -= goals
	end

	def remove_points(points)
		self.points -= points
	end

	def remove_win
		self.wins -= 1
		remove_points(2)
	end

	def remove_loss(ot)
		if ot
			self.ot_losses -= 1
			remove_points(1)
		else
			self.losses -= 1
		end
	end

	def remove_tie
		self.ties -= 1
		remove_points(1)
	end

	def remove_old_stats(old_goals_for, old_goals_against, old_ot)
		if old_goals_for > old_goals_against
			remove_win
		elsif old_goals_against > old_goals_for
			remove_loss(old_ot)
		elsif old_goals_for + old_goals_against > 0
			remove_tie
		end
		remove_goals_for(old_goals_for)
		remove_goals_against(old_goals_against)
	end
end

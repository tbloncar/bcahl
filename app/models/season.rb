class Season < ActiveRecord::Base
	belongs_to :league
	has_many :teams, through: :rosters
	has_many :rosters
	has_many :games

	validates :name, uniqueness: { scope: :league_id }

	after_validation :create_url_path, on: [ :create, :update ]

	def create_url_path
		self.path = name.downcase.gsub(" ", "-").gsub("'", "")
	end

	def name_with_league
		"#{league.name} - #{name}"
	end
end

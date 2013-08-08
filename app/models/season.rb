class Season < ActiveRecord::Base
	belongs_to :league
	has_many :teams, through: :rosters
	has_many :rosters, dependent: :destroy
	has_many :games, dependent: :destroy

	validates :name, uniqueness: { scope: :league_id }

	after_validation :create_url_path, on: [ :create, :update ]

	scope :active, -> { where(active: true) }

	def create_url_path
		self.path = name.downcase.gsub(" ", "-").gsub("'", "")
	end

	def name_with_league
		"#{league.name} - #{name}"
	end
end

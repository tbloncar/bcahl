class Team < ActiveRecord::Base
	has_many :players, through: :memberships
	has_many :memberships

	validates :name, uniqueness: true
	validates :color, presence: true

	after_validation :create_url_path, on: [ :create, :update ]

	def create_url_path
		self.path = name.downcase.gsub(" ", "-").gsub("'", "")
	end
end

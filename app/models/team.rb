class Team < ActiveRecord::Base
	has_many :players, through: :memberships
	has_many :memberships

	validates :name, uniqueness: true
	validates :color, presence: true

	def create_url_path
		name.downcase.gsub(" ", "-").gsub("'", "")
	end
end

class RosterSpot < ActiveRecord::Base
	belongs_to :player
	belongs_to :roster

	validates :player_id, uniqueness: { scope: :roster_id }

	def points
		goals + assists
	end
end

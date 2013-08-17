class Player < ActiveRecord::Base
	has_many :rosters, through: :roster_spots
	has_many :roster_spots, dependent: :destroy

	validates :l_name, uniqueness: { scope: :f_name }

	after_validation :create_url_path, only: [ :create, :update ]
	after_validation :create_full_name, only: [ :create, :update ]

	def create_url_path
		self.path = "#{f_name.downcase}-#{l_name.downcase}"
	end

	def create_full_name
		self.full_name = "#{f_name} #{l_name}"
	end
end

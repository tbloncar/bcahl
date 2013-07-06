class Season < ActiveRecord::Base
	belongs_to :league

	validates :name, uniqueness: { scope: :league_id }

	after_validation :create_url_path, on: [ :create, :update ]

	def create_url_path
		self.path = name.downcase.gsub(" ", "-").gsub("'", "")
	end
end

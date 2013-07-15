class League < ActiveRecord::Base
	has_many :seasons, dependent: :destroy

	validates :name, uniqueness: true

	after_validation :create_url_path, only: [ :create, :update ]

	def create_url_path
		self.path = name.downcase.gsub(" ", "-").gsub("'", "")
	end
end

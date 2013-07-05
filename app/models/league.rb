class League < ActiveRecord::Base
	validates :name, uniqueness: true

	def create_url_path
		name.downcase.gsub(" ", "-").gsub("'", "")
	end
end

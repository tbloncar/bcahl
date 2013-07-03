class Player < ActiveRecord::Base
	validates :email, uniqueness: true
	validates :l_name, uniqueness: { scope: :f_name }

	def create_url_path
		"#{f_name.downcase}-#{l_name.downcase}"
	end

	def full_name
		"#{f_name} #{l_name}".titleize
	end
end

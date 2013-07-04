class Player < ActiveRecord::Base
	has_many :teams, through: :memberships
	has_many :memberships

	validates :email, uniqueness: true
	validates :l_name, uniqueness: { scope: :f_name }

	def create_url_path
		"#{f_name.downcase}-#{l_name.downcase}"
	end

	def full_name
		"#{f_name} #{l_name}".titleize
	end
end

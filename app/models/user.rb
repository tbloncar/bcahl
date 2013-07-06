class User < ActiveRecord::Base
	has_secure_password

	validates :email, uniqueness: true
	validates :l_name, uniqueness: { scope: :f_name }

	after_validation :create_url_path, only: [ :create, :update ]

	def create_url_path
		self.path = f_name.downcase + l_name.first.downcase
	end

	def full_name
		"#{f_name} #{l_name}".titleize
	end
end

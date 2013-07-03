class User < ActiveRecord::Base
	has_secure_password

	def create_url_path
		f_name.downcase + l_name.first.downcase
	end

	def full_name
		"#{f_name} #{l_name}".titleize
	end
end

class Photo < ActiveRecord::Base
	has_attached_file :photo, :styles => { :large => "400x400>", :medium => "300x300>", :thumb => "100x100>" }

	scope :latest, -> { limit(5) }
end
class Photo < ActiveRecord::Base
	belongs_to :gallery
	
	has_attached_file :photo, :styles => { :large => "400x400>", :medium => "300x300>", :thumb => "100x100>" }

	validates :photo, uniqueness: true

	scope :latest, -> { limit(5) }
end
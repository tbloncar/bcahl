class Event < ActiveRecord::Base
	has_attached_file :photo, :styles => { :large => "400x400>", :medium => "300x300>", :thumb => "100x100>" }

	validates :name, uniqueness: { scope: :date_and_time, message: "should not be on the same date at the same time." }
	
	after_initialize :create_url_path, only: [ :create ]
	after_validation :create_url_path, only: [ :update ]

	scope :upcoming, -> { where("date_and_time > ?", Date.yesterday).limit(4) }

	def create_url_path
		self.path = "#{name.downcase.gsub(" ", "-").gsub("'", "")}-#{self.date_and_time.strftime("%m-%d-%y")}" if self.name && self.date_and_time
	end

	def date
  	date_and_time.strftime("%m/%d/%y")
  end

  def time
  	date_and_time.strftime("%I:%M %p")
  end

  def name_and_time
    "#{name} - #{time}"
  end

  def name_and_date
  	"#{name} - #{date}"
  end

	def calendar_class
    "calendar-#{self.class.to_s.downcase}"
  end
end
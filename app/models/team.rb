class Team < ActiveRecord::Base
  has_many :rosters, dependent: :destroy

  validates :name, uniqueness: true
  validates :color, presence: true

  after_validation :create_url_path, on: [ :create, :update ]

  def create_url_path
    self.path = name.downcase.gsub(" ", "-").gsub("'", "")
  end

  def has_rosters?
    self.rosters.count > 1
  end
end

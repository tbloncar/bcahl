class Season < ActiveRecord::Base
  belongs_to :league
  has_many :teams, through: :rosters
  has_many :rosters, dependent: :destroy
  has_many :games, dependent: :destroy

  validates :name, uniqueness: { scope: :league_id }

  after_validation :create_url_path, on: [ :create, :update ]

  scope :active, -> { where(active: true) }

  def point_leaders
    rosters.includes(:roster_spots).flat_map(&:roster_spots).
      sort { |a, b| b.points <=> a.points }.take(50)
  end

  def create_url_path
    self.path = name.downcase.gsub(" ", "-").gsub("'", "")
  end

  def name_with_league
    "#{league.name} - #{name}"
  end
end

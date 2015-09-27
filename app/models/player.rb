class Player < ActiveRecord::Base
  has_many :rosters, through: :roster_spots
  has_many :roster_spots, dependent: :destroy

  validates :l_name, uniqueness: { scope: :f_name }

  after_validation :create_url_path, only: [ :create, :update ]

  default_scope -> { order(f_name: :asc) }

  def full_name
    "#{f_name} #{l_name}"
  end

  def create_url_path
    self.path = "#{f_name.downcase}-#{l_name.downcase}"
  end
end

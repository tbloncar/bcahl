class RosterSpot < ActiveRecord::Base
  belongs_to :player
  belongs_to :roster

  has_many :participations, dependent: :destroy

  validates :player_id, uniqueness: { scope: :roster_id }

  def goals
    participations.pluck(:goals).inject(:+) || 0
  end

  def assists
    participations.pluck(:assists).inject(:+) || 0
  end

  def pims
    participations.pluck(:pim).inject(:+) || 0
  end
end

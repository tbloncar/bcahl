class Game < ActiveRecord::Base
  include Schedulable

  belongs_to :season
  belongs_to :home_roster, class_name: 'Roster', foreign_key: 'home_id'
  belongs_to :away_roster, class_name: 'Roster', foreign_key: 'away_id'
  has_many :participations, dependent: :destroy

  validates :date_and_time, presence: true, uniqueness: { scope: :season_id, message: "should not be scheduled at the same time as other games." }
  validates :season_id, presence: true
  validates :home_id, numericality: true
  validates :away_id, numericality: true
  validate :home_and_away_cannot_be_same

  default_scope -> { order(date_and_time: :asc) }
  scope :upcoming, -> { where("date_and_time > ?", Date.today).limit(4) }
  scope :recent, -> {
    where("date_and_time < ? AND (home_goals > ? OR away_goals > ?)",
          Date.today, 0, 0).
          order(date_and_time: :desc).limit(4)
  }

  def home_and_away_cannot_be_same
    if home_id == away_id
      errors.add(:away_id, "must be different.")
    end
  end

  def winner
    return home_team_name if home_goals == away_goals
    home_goals > away_goals ? home_team_name : away_team_name
  end

  def loser
    winner == home_team_name ? away_team_name : home_team_name
  end

  def winner_goals
    return home_goals if home_goals == away_goals
    home_goals > away_goals ? home_goals : away_goals
  end

  def loser_goals
    winner_goals == home_goals ? away_goals : home_goals
  end

  def score_summary
    verb = home_goals == away_goals ? "tied" : "def."
    "#{winner} (#{winner_goals}) #{verb} #{loser} (#{loser_goals})"
  end

  def home_team_name
    home_roster.team.name
  end

  def away_team_name
    away_roster.team.name
  end

  def print_result
    "#{home_goals} - #{away_goals}"
  end

  def scored?
    home_goals || away_goals
  end

  def name
    "#{home_team_name} vs. #{away_team_name}"
  end

  def name_and_time
    "#{name} - #{time}"
  end

  def name_and_date
    "#{name} - #{date}"
  end

  def name_date_and_time
    "#{name} on #{date} at #{time}"
  end

  def calendar_class
    "calendar-#{self.class.to_s.downcase}"
  end
end

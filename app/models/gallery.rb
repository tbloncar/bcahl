class Gallery < ActiveRecord::Base
  has_many :photos, dependent: :destroy

  validates :name, presence: true
  validates :date_start, presence: true
  validates :date_end, presence: true

  def cover_photo_path
    unless photos.empty?
      photos.first.photo.url(:medium)
    else
      "/assets/bcahl.jpg"
    end
  end

  def name_and_date
    date_section = if date_start == date_end
      "#{pretty_date(date_start)}"
    else
      "#{pretty_date(date_start)} - #{pretty_date(date_end)}"
    end
    "#{name} / #{date_section}"
  end

  def pretty_date(date)
    date.strftime("%B %e, %Y")
  end
end

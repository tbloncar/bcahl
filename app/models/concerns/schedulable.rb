module Schedulable
  extend ActiveSupport::Concern

  def date
    date_and_time.strftime("%-m/%d/%y")
  end

  def time
    return "TBD" if self.time_tbd
    date_and_time.strftime("%-l:%M%P")
  end
end

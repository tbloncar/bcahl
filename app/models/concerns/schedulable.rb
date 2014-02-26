module Schedulable
  extend ActiveSupport::Concern

  def date
  	date_and_time.strftime("%-m/%d/%y")
  end

  def time
  	date_and_time.strftime("%-l:%M%P")
  end
end

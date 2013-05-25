class DateUtil
  def self.todatestring(date)
    date.month.to_s+"/"+date.day.to_s+"/"+date.year.to_s
  end
end
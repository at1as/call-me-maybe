module ApplicationHelper

  def date_str(date)
    return "" if date.nil? || date.empty?
    Date.parse(date)
  end

  def am_or_pm_from_24h(hour)
    "#{hour % 12}" + " " + "#{ hour < 12 ? "AM" : "PM"  }"
  end

end

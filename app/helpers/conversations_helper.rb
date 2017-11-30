module ConversationsHelper

  AVAILABLE ||= [
    ["monday",   17, 21],
    ["thursday", 18, 22]
  ]

  def available_date(date, validate_time: false)
    # TODO: Read this from a YAML file
    return false if date < DateTime.now

    AVAILABLE.any? do |target_day|
      if validate_time
        date.send(:"#{target_day[0]}?") && date.hour > target_date[1] && date.hour < target_date[2]
      else
        date.send(:"#{target_day[0]}?")
      end
    end
  end

  def start_of_window(date)
    AVAILABLE.select { |day| date.send(:"#{day[0]}?") }.first[1]
  end
  
  def end_of_window(date)
    AVAILABLE.select { |day| date.send(:"#{day[0]}?") }.first[2]
  end

  def times_available(date)
    days = AVAILABLE.select { |day| DateTime.parse(date).send(:"#{day[0]}?") }

    (days.first[1]..days.first[2]).to_a.map { |time| [time, time] }
  end

  def reminder_times
    [
      ["5 minutes",   5],
      ["15 minutes",  15],
      ["30 minutes",  30],
      ["1 hour",      60],
      ["4 hours",     240],
      ["1 day",       1440]
    ]
  end
  
end

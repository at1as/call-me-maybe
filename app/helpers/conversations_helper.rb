module ConversationsHelper

  # Day, Start Hour, End Hour
  AVAILABLE ||= [
    ["monday",   17, 21],
    ["thursday", 18, 22]
  ]

  DEFAULT_TIMEZONE ||= "Pacific Time (US & Canada)"

  def date_available?(date, validate_time: false)
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

  def date_booked?(date, conversations)
    return false if date < DateTime.now

    conversations.any? do |convo|
      [date.day, date.month, date.year] == [convo.start_time.day, convo.start_time.month, convo.start_time.year]
    end
  end

  def in_the_future?(conversation)
    DateTime.now < conversation.start_time
  end

  def start_of_window(date)
    AVAILABLE.select { |day| date.send(:"#{day[0]}?") }.first[1]
  end
  
  def end_of_window(date)
    AVAILABLE.select { |day| date.send(:"#{day[0]}?") }.first[2]
  end

  def times_available(date, timezone)
    days = AVAILABLE.select { |day| DateTime.parse(date).send(:"#{day[0]}?") }

    (days.first[1]..days.first[2]).to_a.map do |hour|
      [
        "#{get_datetime(date, hour, timezone).to_time}",
        hour 
      ]
    end
  end

  def reminder_times(date)
    # TODO: pass in time, not just day
    now = DateTime.now
    time_until_call = ((DateTime.parse(date) - now) * 24 * 60 * 60).to_i
    [
      ["None",        0],
      ["5 minutes",   5],
      ["15 minutes",  15],
      ["30 minutes",  30],
      ["1 hour",      60],
      ["4 hours",     240],
      ["1 day",       1440]
    ].select { |x| x.second < time_until_call }
  end

  def get_datetime(date, hour, timezone = nil)
    default_timezone_offset = ActiveSupport::TimeZone.new(DEFAULT_TIMEZONE).utc_offset / 3600
    DateTime.parse("#{date} #{hour}:00 #{default_timezone_offset}").in_time_zone(timezone)
  end

  def timezone_offset_delta(timezone)
    default_timezone_offset - ActiveSupport::TimeZone.new(timezone).utc_offset
  end

  def default_timezone_offset(timezone_name = DEFAULT_TIMEZONE)
    ActiveSupport::TimeZone.new(timezone_name).utc_offset 
  end

  def timezone_offset_in_hours(timezone)
    timezone / (60*60)
  end

  def timeify_hour(hour)
    "#{hour % 24}:00"
  end

end

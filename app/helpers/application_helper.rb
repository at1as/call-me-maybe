module ApplicationHelper
  
  # Day, Start Hour, End Hour
  AVAILABLE ||= [
    ["monday",   17, 21],
    ["thursday", 18, 22]
  ].freeze

  def date_str(date)
    return "" if date.nil? || date.empty?
    Date.parse(date)
  end

  def am_or_pm_from_24h(hour)
    (hour % 12).to_s + " " + "#{ hour < 12 ? "AM" : "PM" }"
  end

  def bootstrap_class_for(flash_type)
    {
      success: "alert-success",
      error: "alert-error",
      alert: "alert-warning",
      notice: "alert-info"
    }[flash_type.to_sym] || flash_type.to_sym
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in hello") do 
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message 
      end)
    end
    nil
  end

end

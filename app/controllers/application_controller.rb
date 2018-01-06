class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  DEFAULT_TIMEZONE ||= "Pacific Time (US & Canada)"
end

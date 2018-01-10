class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  DEFAULT_TIMEZONE ||= "Pacific Time (US & Canada)"

  include SessionsHelper
  
  private

    def logged_in_user
      unless logged_in?
        store_location
        flash['alert-danger'] = "Please log in to access that page."
        redirect_to login_url
      end
    end
end

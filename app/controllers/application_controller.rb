# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :admin?
  before_filter :redirect_pages_without_www
  
  # Comment once is correct
  #USERNAME, PASSWORD = "admin", "test"
  #before_filter :authenticate_with_http if RAILS_ENV == "production"

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  before_filter :set_locale
  
  def set_locale 
    I18n.locale = 'es'
  end
  
  def admin?
    session[:admin] ? true : false
  end    
  
  def admin_required
    if session[:admin].blank?
      flash[:error] = t("controllers.application.not_authorized")
      headers["Status"] = "301 Moved Permanently"  
      redirect_to home_url
    end
  end
  
  def redirect_pages_without_www
    if RAILS_ENV == 'production' && request.host.scan(/^www./).blank? && request.host.scan('heroku').blank?
      headers["Status"] = "301 Moved Permanently"  
      redirect_to request.url.gsub('http://','http://www.')
    end
  end
    
    
  private
  def authenticate_with_http
    authenticate_or_request_with_http_basic do |username, password|
      username == USERNAME && password == PASSWORD
    end
  end
  
end

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :admin?

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
      redirect_to home_url
    end
  end
  
end

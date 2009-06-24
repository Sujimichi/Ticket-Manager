# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  layout 'main'
  gem 'json'
  require 'json'
  require 'authlogic'

  filter_parameter_logging :password
  before_filter :require_login
  helper_method :current_user, :redirect_back_or_default
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def authentication_failed!
    store_location
    flash[:notice] = "You must be logged in"
    redirect_to root_url
  end

  def not_allowed! redirect = root_url
    flash[:error] = "You cannot access this"
    flash[:fade] = true
    redirect_to redirect and return
  end

  def not_found! redirect = root_url
    flash[:notice] = "The requested item can not be found"
    flash[:fade] = true
    redirect_to redirect and return
  end

  def require_login
    return authentication_failed! unless current_user
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default = root_url)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

end

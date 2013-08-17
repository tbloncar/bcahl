class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  before_action :redirect_to_under_construction

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def redirect_to_under_construction
  	redirect_to "/under-construction" if current_user.try(:email) != ENV['SUPER_ADMIN_EMAIL'] && Rails.env.production?
  end
end

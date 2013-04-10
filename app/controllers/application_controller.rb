class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    @recent_media = current_user.instagram.user_recent_media(:count => -1)
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end

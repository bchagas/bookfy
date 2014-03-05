class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    if current_user
      user_id = current_user.id
      @albums = Album.where(user_id: user_id)
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def find_recent_media
    @recent_media = current_user.instagram.user_recent_media(:count => 10)
  end
end

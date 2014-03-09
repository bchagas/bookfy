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

  def find_recent_media(options = {count: 30})
    @recent_media = current_user.instagram.user_recent_media(options)
    @page_max_id = @recent_media.pagination.next_max_id
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    if current_user
      user_id = current_user.id
      @albums = Album.where(user_id: user_id)
    end
  end

  def load_photos
    max_id = params[:max_id]
    user_photos(max_id: max_id)
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def require_login
    unless current_user
      flash[:notice] = "You are not logged id"
      redirect_to root_path && return
    end
  end

  def user_photos(options = {count: 30})
    if current_user
      @user_photos = current_user.instagram.user_recent_media(options)
      @page_max_id = @user_photos.pagination.next_max_id
    else
      redirect_to root_path
    end
  end
end

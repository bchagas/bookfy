class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :body_class

  def index
    if current_user
      user_id = current_user.id
      @albums = Album.where(user_id: user_id)
    end
  end

  def home
    if current_user
      redirect_to albums_path
    else
      render layout: "home"
    end
  end

  def load_photos
    @current_album = Album.friendly_id.find(params[:album_id])
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
      flash[:notice] = "You are not logged in"
      redirect_to home_path
    end
  end

  def user_photos(options = {count: 30})
    if current_user
      @user_photos = current_user.instagram.user_recent_media(options)
      @page_max_id = @user_photos.pagination.next_max_id
    else
      redirect_to home_path
    end
  end

  def body_class
    if current_user
      @body_class = "user #{action_name}"
    else
      @body_class = 'home'
    end
  end
end

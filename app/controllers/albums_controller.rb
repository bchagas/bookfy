class AlbumsController < ApplicationController
  before_filter :user_photos, only: [:new]
  before_filter :require_login, except: [:show]
  include ApplicationHelper

  def index
    user_id = current_user.id
    @albums = Album.where(user_id: user_id)
    @user = current_user
    @body_class = 'user'
  end

  def edit
    @album = Album.friendly_id.find(params[:id])
  end

  def show
    @album = Album.friendly_id.find(params[:id])
    @photos = Photo.where(album_id: @album.id).order('position')
    current_user ||= User.find(@album.user_id)
  end

  def new
    @album = Album.new
    @current_album = Album.friendly_id.find(params[:album_id]) if controller_name == 'photos' and action_name == 'new'
    @user_photos.each do |media|
      @album.photos.build(photo_id: media.id)
    end
  end

  def create
    @album = Album.new(params[:album])

    respond_to do |format|
      if @album.save
        @last_album = current_user.albums.last
        format.html { redirect_to new_album_photo_path(@album), :notice => 'Album created' }
      else
        format.html { render action: :new, :error => @album.errors.full_messages.to_sentence }
      end
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy

    respond_to do |format|
      format.html { redirect_to albums_path, :notice => 'Album created' }
    end
  end

  def update
    @album = Album.friendly_id.find(params[:id])
    @album.update_attributes(name: params[:album][:name])
    respond_to do |format|
      if @album.save
        format.html { redirect_to album_path(@album), :notice => 'Photos added to album' }
      else
        format.html { render action: :new, :error => @album.errors.full_messages.to_sentence }
      end
    end
  end
end

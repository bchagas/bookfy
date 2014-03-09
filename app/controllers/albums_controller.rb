class AlbumsController < ApplicationController
  before_filter :find_recent_media, except: :show

  def index
    user_id = current_user.id
    @albums = Album.where(user_id: user_id)
  end

  def show
    @album = Album.friendly_id.find(params[:id])
    @photos = Photo.where(album_id:  params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end

  def new
    @album = Album.new
    @recent_media.each do |media|
      @album.photos.build(url: media.images.thumbnail.url)
    end
  end

  def create
    @album = Album.new(params[:album])

    respond_to do |format|
      if @album.save
        format.html { redirect_to albums_path, :notice => 'Album created' }
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
    @album = Album.find(params[:id])
    respond_to do |format|
      if @album.save
        format.html { redirect_to album_path(@album), :notice => 'Photos added to album' }
      else
        format.html { render action: :new, :error => @album.errors.full_messages.to_sentence }
      end
    end
  end
end

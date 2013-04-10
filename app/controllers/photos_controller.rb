class PhotosController < AlbumsController
  before_filter :find_recent_media, :find_album
  def index; end
  def create
    @photo = Photo.new
    @photo.album(params[:album_id])
    @photo.update_attributes(params[:photos])

    respond_to do |format|
      if @photo.save
        format.html { redirect_to root_path, :notice => 'Album created' }
      else
        format.html { render action: :new, :error => @photo.errors.full_messages.to_sentence }
      end
    end
  end

  def find_album
    @album = Album.find(params[:album_id])
  end
end

class PhotosController < AlbumsController
  before_filter :find_album

  def create
    @photo = Photo.new
    @photos = params[:album][:photos][:url]
    album_id = params[:album_id]
    @photos.map { |photo| Photo.create(:url => photo, :album_id => album_id).save }

    respond_to do |format|
      if @photo.save
        format.html { redirect_to album_path(@album), :notice => 'Album created' }
      else
        format.html { render action: :new, :error => @photo.errors.full_messages.to_sentence }
      end
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to album_path(@album), :notice => 'Album created' }
    end
  end

  private

  def find_album
    @album = Album.find(params[:album_id])
  end
end

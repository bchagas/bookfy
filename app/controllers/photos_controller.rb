class PhotosController < AlbumsController
  before_filter :find_album

  def create
    @photo = Photo.new
    @photos = params[:album][:photos][:photo_id].reject!{ |p| p == "0" }
    album = Album.find(params[:album_id])
    album_id = album.id
    @photos.map { |photo| Photo.create(:photo_id => photo, :album_id => album_id).save }

    if @photo.save
      redirect_to album_path(@album), flash: { notice: 'Album created' }
    else
      redirect_to new_album_photo_path(@album), flash: { error: @photo.errors.full_messages.to_sentence }
    end
  end

  def destroy
    photo = Photo.find_by_photo_id(params[:id])
    @photo = Photo.find(photo.id)
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

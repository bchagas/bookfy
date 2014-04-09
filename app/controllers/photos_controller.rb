class PhotosController < AlbumsController
  before_filter :find_album

  def create
    @photo = Photo.new
    @photos = params[:album][:photos][:data].reject!{ |p| p == "0" }
    album = Album.find(params[:album_id])
    album_id = album.id

    @photos.each do |photo|
      photo = JSON.parse(photo)
      p = Photo.new
      p.album_id  = album_id
      p.photo_id  = photo['id']
      p.data      = {
                  text: photo['caption']['text'],
                  image_low: photo['images']['low_resolution']['url'],
                  image_standard: photo['images']['standard_resolution']['url'],
                  image_thumbnail: photo['images']['thumbnail']['url']
      }

      p.save
    end

    if @photo.save
      redirect_to album_path(@album), flash: { notice: 'Album created' }
    else
      redirect_to new_album_photo_path(@album), flash: { error: @photo.errors.full_messages.to_sentence }
    end
  end

  def show_photo
    album = Album.find(params[:album_id])
    @photo = album.photos.find_by_id(params[:id])
  end

  def destroy
    photo = Photo.find_by_id(params[:id])
    photo.destroy

    respond_to do |format|
      format.html { redirect_to album_path(@album), :notice => 'Photo removed' }
    end
  end

  private

  def find_album
    @album = Album.find(params[:album_id])
  end
end

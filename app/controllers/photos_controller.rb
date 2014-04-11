class PhotosController < AlbumsController
  before_filter :find_album
  before_filter :require_login, except: [:show_photo]

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
      p.data = {
        type:               photo['type'],
        text:               photo['caption'].nil? ? '' : photo['caption']['text'],
        image_low:          photo['images']['low_resolution']['url'],
        image_standard:     photo['images']['standard_resolution']['url'],
        image_thumbnail:    photo['images']['thumbnail']['url'],
        video_low:          photo['type'] == 'video' ? photo['videos']['low_resolution']['url'] : '',
        video_standard:     photo['type'] == 'video' ? photo['videos']['standard_resolution']['url'] : ''
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

  def sort
    params[:photo].each_with_index do |id, index|
      photos = Photo.find id
      photos.update_attributes({position: index+1})
    end

    render nothing: true
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

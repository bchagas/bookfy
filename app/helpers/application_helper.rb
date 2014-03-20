module ApplicationHelper
  def load_photo(id)
    photo = Photo.find(id)
    album = Album.find(photo)
    user = User.find(album.user_id)

    binding.pry
    user.instagram.media_item(id).images.standard_resolution.url
  end
end

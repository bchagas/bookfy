class AlbumPresenter < ClassicPresenter::Base
  def display_albums
    if self.empty? and current_user
      context.render "partials/empty_object", object: self
    else
      context.render "partials/albums", albums: self
    end
  end

  def display_cover
    if self.photos.empty?
      context.image_tag 'default-cover.jpg', alt: 'Album empty'
    else
      context.image_tag context.load_photo(self.photos.first.photo_id)
    end
  end
end

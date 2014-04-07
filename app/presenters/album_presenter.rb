class AlbumPresenter < ClassicPresenter::Base
  def display_albums
    if self.present?
      context.render "partials/albums", albums: self
    else
      context.render "partials/empty_object", object: 'albums'
    end
  end

  def display_photos
    if self.present?
      context.render "partials/photos", photos: self
    else
      context.render "partials/empty_object", object: 'photos'
    end
  end

  def display_cover
    if self.photos.empty?
      context.image_tag 'default-cover.jpg', alt: 'Album empty'
    else
      context.image_tag context.load_photo(self.photos.first.photo_id).images.low_resolution.url
    end
  end

  def display_actions
    if context.current_user
      context.render "partials/actions", album: self
    end
  end
end

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
      context.image_tag self.photos.first.data['image_low']
    end
  end

  def display_actions
    if context.current_user and context.current_user.id == self.user_id
      context.render "partials/actions", album: self
    end
  end
end

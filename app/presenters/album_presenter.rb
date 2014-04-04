class AlbumPresenter < ClassicPresenter::Base
  def display_albums
    if self.empty?
      context.render "partials/empty_object", object: self
    else
      context.render "partials/albums", albums: self
    end
  end
end

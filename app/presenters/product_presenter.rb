class AlbumPresenter < ClassicPresenter::Base
  def display_albums
    context.render "albums/albums", :albums => self
  end
end

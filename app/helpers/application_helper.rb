module ApplicationHelper
  def load_photo(id)
    user = current_user
    user.instagram.media_item(id).images.standard_resolution.url
  end
end

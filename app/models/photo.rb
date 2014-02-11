class Photo < ActiveRecord::Base
  attr_accessible :url, :album_id
end

class Photo < ActiveRecord::Base
  attr_accessible :name, :album_id
  has_many :albums
end

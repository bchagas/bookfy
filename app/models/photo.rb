class Photo < ActiveRecord::Base
  attr_accessible :url, :album_id
  has_many :albums, :dependent => :destroy
end

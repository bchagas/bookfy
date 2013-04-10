class Albumphoto < ActiveRecord::Base
  attr_accessible :album_id, :created_at, :photo_id
  belongs_to :photo
  belongs_to :album
end

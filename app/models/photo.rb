class Photo < ActiveRecord::Base
  attr_accessible :photo_id, :album_id, :data
  serialize :data, ActiveRecord::Coders::Hstore
end

class Photo < ActiveRecord::Base
  attr_accessible :position, :photo_id, :album_id, :data
  serialize :data, ActiveRecord::Coders::Hstore
  acts_as_list
end

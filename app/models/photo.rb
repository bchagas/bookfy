class Photo < ActiveRecord::Base
  attr_accessible :name
  has_many :albumphotos
  has_many :albums, :through => :albumphotos
end

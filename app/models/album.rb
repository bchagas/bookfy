class Album < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user
  has_many :albumphotos
  has_many :photos, through: :albumphotos

  validates_presence_of :name
end

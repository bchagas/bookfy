class Album < ActiveRecord::Base
  attr_accessible :name, :photos, :user_id
  belongs_to :user
  has_many :photos, :dependent => :destroy

  validates_presence_of :name, :user_id
end

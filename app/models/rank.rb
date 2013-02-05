class Rank < ActiveRecord::Base
  attr_accessible :title, :power, :icon

  has_many :users
  has_attached_file :icon, :dependent => :destroy

  validates_presence_of :title
end

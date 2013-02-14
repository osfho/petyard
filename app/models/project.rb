class Project < ActiveRecord::Base
  attr_accessible :description, :feature_image, :invite_only, :permalink, :status, :title, :visible, :x_coordinate, :y_coordinate, :z_coordinate

  has_many :project_memberships, :dependent => :destroy
  has_many :users, :through => :project_memberships
  has_attached_file :avatar, :styles => { :original => "100x100>" }, :dependent => :destroy

  validates :title, :presence => { :message => "* Your project must have a title." }

  def to_param
    permalink
  end
end

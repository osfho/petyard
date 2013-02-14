class Project < ActiveRecord::Base
  attr_accessible :description, :feature_image, :invite_only, :permalink, :status, :title, :visible, :x_coordinate, :y_coordinate, :z_coordinate

  has_many :project_memberships, :dependent => :destroy
  has_many :users, :through => :project_memberships
  has_attached_file :feature_image, :styles => { :original => "613x613>" }, :dependent => :destroy

  validates :title, :presence => { :message => "* Your project must have a title." }
  validates :title, :uniqueness => { :message => "* There is already a project with this title.", :case_sensitive => false }
  validates_attachment :feature_image, :content_type => { :content_type => "image/jpg", :content_type => "image/png" }, :size => { :in => 0..3.megabytes }

  default_scope :order => ("title asc")
  scope :visible, where(:visible => true)
  def to_param
    permalink
  end
end

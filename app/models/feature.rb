class Feature < ActiveRecord::Base
  attr_accessible :position, :title, :url, :image

  has_attached_file :image, :styles => { :large => "824x338#", :thumb => "412x169>" }, :dependent => :destroy
  
  validates :title, :presence => {:message => "* A title is required."}
  validates_attachment :image, :content_type => { :content_type => "image/jpg", :content_type => "image/png" }, :size => { :in => 0..3.megabytes }

  default_scope order("position asc")
end
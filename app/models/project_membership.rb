class ProjectMembership < ActiveRecord::Base
  attr_accessible :project_id, :role, :user_id

  belongs_to :user
  belongs_to :project

  validates :user_id, :presence => { :message => "* You must choose a user." }

  scope :foundership, where(:role => "founder")
  scope :adminship, where(:role => "admin")
  scope :membership, where(:role => "member")
end

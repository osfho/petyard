class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :avatar

  authenticates_with_sorcery!

  belongs_to :rank
  has_many :topics, :dependent => :destroy
  has_many :posts, :dependent => :destroy
  has_many :mod_messages, :dependent => :destroy
  has_many :project_memberships
  has_many :projects, :through => :project_memberships
  has_attached_file :avatar, :styles => { :large => "100x100>", :medium => "60x60>", :small => "35x35>" }, :dependent => :destroy
  
  validates :password, :presence => { :message => "* You must choose a password." }, :on => :create
  validates :password, :confirmation => { :message => "* Password confirmation does not match password." }
  validates :username, :presence => { :message => "* You must enter your Minec\/^[^ ]+$\/raft username." }
  validates :username, :uniqueness => { :case_sensitive => false, :message => "* This username has already been taken." }
  validates :username, :format => { :with => /^[^\s]+$/, :message => "* Your Minecraft username may not have spaces." }
  validates_attachment :avatar, :content_type => { :content_type => "image/jpg", :content_type => "image/png" }, :size => { :in => 0..30.kilobytes }

  def to_param
    username
  end

  def minotar(size)
    if avatar.blank?
      "https://minotar.net/avatar/#{username}/#{size}"
    else
      case size
      when 35
        avatar.url(:small)
      when 60
        avatar.url(:medium)
      when 100
        avatar.url(:large)
      else
        avatar.url(:large)
      end
    end
  end

  def has_power(powercheck)
    rank.power >= powercheck || false
  end

  def unverified?
    rank == Rank.find_by_title('unverified')
  end

  def self.find_by_username(username)
    find(:first, :conditions => ["LOWER(username) = ?", username.downcase])
  end

  def project_role(project)
    if project_memberships.find_by_project_id(project.id)
      return self.project_memberships.find_by_project_id(project.id).role
    else
      return false
    end
  end

end

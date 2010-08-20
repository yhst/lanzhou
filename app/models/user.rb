require "digest/sha1"
class User < ActiveRecord::Base
  has_many :photos
  has_many :topics

  #attr_accessor :password, :confirm_password
  #attr_accessor :hased_pass
  validates_length_of :login_name, :minimum => 4
  #attr_accessible :group_id,:mobile,:personality,:pic_url,:password, :confirmation,:login_name,:email,:display_name,:sex,:website,:im,:created_at,:where,:description,:topic_count
  validates_uniqueness_of :login_name,:display_name
  validates_presence_of :login_name,:display_name,:password, :password_confirmation,:on => :create

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, 
                      :on => :create,
                      :message=>"邮件地址格式不正确，请检查..."                     
                      
  attr_accessor :password, :password_confirmation, :file
  validates_confirmation_of :password,:on => :create
                     
  def before_create
    self.hashed_pass= User.hash_password(self.password)
  end
  
#   def before_create
#      self.hashed_password = User.hash_password(self.password)
#    end
  
#    def validate_on_create
#      @email_format = Regexp.new(/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/)
#      errors.add(:email, "must be a valid format") unless @email_format.match(email)
#      errors.add(:confirm_password, "does not match") unless password == confirm_password
#      errors.add(:password, "cannot be blank") unless !password or password.length > 0
#    end
  
  def after_create
      @password = nil
      @confirm_password = nil
  end
  
  #��½
  def self.login(name,password,group_id)
    hashed_password = hash_password(password || "")
    find(:first,
         :conditions => ["login_name = ? and hashed_pass = ? and group_id = ?",name,hashed_password,group_id]
    )
  end
  
  #
  def try_to_login
    User.login(self.login_name,self.password,self.group_id)
  end
  
  def self.can_login(user_id,password)
    hashed_password = self.hash_password(password || "")
    find(:first,
         :conditions => ["id = ? and hashed_pass = ?",user_id,hashed_password]
    )
  end
  
  private
#  def self.hash_password(password)
#    Digest::SHA1.hexdigest(password)
#  end
  
  # hash password for storage in database
  def self.hash_password(password)
    Digest::SHA1.hexdigest(password)
  end
 
  # clean string to remove spaces and force lowercase
  def self.clean_string(string)
    (string.downcase).gsub(" ","")
  end
  
end


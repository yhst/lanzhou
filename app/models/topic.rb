class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :comments ,:dependent => true, :order => "create_at ASC"
end

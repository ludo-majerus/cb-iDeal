class User < ActiveRecord::Base
  has_secure_password

  has_many :idea
  has_many :comment
  
  attr_accessible :nickname, :email, :password, :password_confirmation, :user_id, :idea_id

  validates :password, :presence => { :on => :create }
  validates :email, :presence => true, :uniqueness => true

end

class Idea < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :category
  has_many :comment

  attr_accessible :title, :body, :category_id, :user_id, :comment_id, :status

  validates :title, :length => { :maximum => 140 }
  validates :body, :length => { :maximum => 2000 }
  validates :user_id, :presence => { :on => :create }
  validates :category_id, :presence => { :on => :create }
  
end

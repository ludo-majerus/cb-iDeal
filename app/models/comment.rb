class Comment < ActiveRecord::Base
  attr_accessible :body
  
  belongs_to :idea
  belongs_to :user

  attr_accessible :body

  validates :body, :presence => true, :length => { :maximum => 500 }
  validates :user_id, :presence => { :on => :create }
  validates :idea_id, :presence => { :on => :create }

end

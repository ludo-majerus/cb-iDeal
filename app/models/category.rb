class Category < ActiveRecord::Base
  
  belongs_to :idea

  attr_accessible :name

  validates :name, :length => { :maximum => 50 }
end

class Post < ActiveRecord::Base
  acts_as_indestructible
  
  has_many :comments
end

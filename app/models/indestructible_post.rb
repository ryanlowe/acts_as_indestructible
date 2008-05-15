class IndestructiblePost < ActiveRecord::Base
  acts_as_indestructible
  
  has_many :comments, :class_name => "IndestructibleComment"
end

class IndestructibleComment < ActiveRecord::Base
  acts_as_indestructible
  
  belongs_to :post, :class_name => "IndestructiblePost"
end

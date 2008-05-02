class Comment < ActiveRecord::Base
  acts_as_indestructible
  
  belongs_to :post
end

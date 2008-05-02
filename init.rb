require 'acts_as_indestructible'
ActiveRecord::Base.send(:include, ActiveRecord::Acts::Indestructible)
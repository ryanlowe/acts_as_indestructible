module ActiveRecord #:nodoc:
  module Acts #:nodoc:
    module Indestructible #:nodoc:
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      module ClassMethods
      end
      
      module SingletonMethods
      end
      
      module InstanceMethods
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActiveRecord::Acts::Indestructible)
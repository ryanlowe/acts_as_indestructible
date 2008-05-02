module ActiveRecord #:nodoc:
  module Acts #:nodoc:
    module Indestructible #:nodoc:
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      module ClassMethods
        def acts_as_indestructible(options = {})
          extend ActiveRecord::Acts::Indestructible::SingletonMethods
          include ActiveRecord::Acts::Indestructible::InstanceMethods
        end
      end
      
      module SingletonMethods
        def delete(id)
          raise "Is not allowed"
        end
        def delete_all(conditions = nil)
          raise "Is not allowed"
        end
      end
      
      module InstanceMethods
        def destroyed?
          !self[:deleted_at].nil?
        end
        def destroy
          return if destroyed?
          # a naive implementation for initial testing
          self[:deleted_at] = Time.now
          save
        end
      end
    end
  end
end
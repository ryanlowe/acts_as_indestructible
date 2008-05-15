module ActiveRecord #:nodoc:
  module Acts #:nodoc:
    module Indestructible #:nodoc:
      def self.included(base)
        base.extend(ClassMethods)
        class << base
          alias_method :super_calculate, :calculate
        end
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
        def calculate(operation, column_name, options = {})
          super_calculate(operation, column_name, options_excluding_deleted(options))
        end
        
        #protected
        
          def options_excluding_deleted(options)
            options = Hash.new if options.nil?
            deleted_condition = "deleted_at IS NULL"
            if options.has_key?(:conditions)
              if options[:conditions].instance_of? Array
                options[:conditions][0] = deleted_condition+" AND "+options[:conditions][0]
              else
                options[:conditions] = deleted_condition+" AND "+options[:conditions]
              end
            else
              options[:conditions] = deleted_condition
            end
            options
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
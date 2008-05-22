module ActiveRecord #:nodoc:
  module Acts #:nodoc:
    module Indestructible #:nodoc:
      def self.included(base)
        base.extend(ClassMethods)
        class << base
          alias_method :super_calculate, :calculate
          alias_method :super_exists?,   :exists?
        end
      end
      
      module ClassMethods
        
        def acts_as_indestructible(options = {})
          extend ActiveRecord::Acts::Indestructible::SingletonMethods
          include ActiveRecord::Acts::Indestructible::InstanceMethods
        end
        
      end
      
      module SingletonMethods
        
        def destroy_all(user, conditions = nil)
          find(:all, :conditions => conditions).each { |object| object.destroy(user) }
        end
        
        def delete(id)
          raise "Is not allowed"
        end
        
        def delete_all(conditions = nil)
          raise "Is not allowed"
        end
        
        def calculate(operation, column_name, options = {})
          super_calculate(operation, column_name, options_excluding_deleted(options))
        end
        
        def exists?(id_or_conditions, options = {})
          include_destroyed = options[:include_destroyed]
          return super_exists?(id_or_conditions) if include_destroyed # revert to normal behaviour
          case id_or_conditions
            when Integer, String
              id_or_conditions = [destroyed_condition+" AND #{quoted_table_name}.id = ?",id_or_conditions]
            when Array
              id_or_conditions[0] = destroyed_condition+" AND "+id_or_conditions[0]
            when Hash
              include_destroyed = (id_or_conditions.has_key? :include_destroyed and id_or_conditions[:include_destroyed])
              unless include_destroyed
                id_or_conditions[:deleted_at] = nil
              end
              id_or_conditions.delete :include_destroyed
          end
          super_exists?(id_or_conditions)
        end
        
        #protected
        
          def destroyed_condition
            "#{quoted_table_name}.deleted_at IS NULL"
          end
        
          def options_excluding_deleted(options)
            options = Hash.new if options.nil?
            if options.has_key?(:conditions)
              if options[:conditions].instance_of? Array
                options[:conditions][0] = destroyed_condition+" AND "+options[:conditions][0]
              else
                options[:conditions] = destroyed_condition+" AND "+options[:conditions]
              end
            else
              options[:conditions] = destroyed_condition
            end
            options
          end
          
      end
      
      module InstanceMethods
        
        def destroyed?
          !self[:deleted_at].nil?
        end
        
        def destroy(user)
          return if user.nil? or !user.is_a? ActiveRecord::Base # ...more conditions?
          return if destroyed?
          self[:deleted_at] = Time.now
          self[:deleted_by] = user.id
          save
        end
        
      end
    end
  end
end
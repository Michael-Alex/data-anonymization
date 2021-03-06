require 'active_record'
require 'composite_primary_keys'
require 'logger'

module DataAnon
  module Utils

    class MassAssignmentIgnoreSanitizer < ActiveModel::MassAssignmentSecurity::Sanitizer
      def process_removed_attributes(attrs)
      end
    end

    class TempDatabase < ActiveRecord::Base
      self.abstract_class = true
    end

    class SourceDatabase < ActiveRecord::Base
      self.abstract_class = true
    end

    class DestinationDatabase < ActiveRecord::Base
      self.abstract_class = true
    end

    class BaseTable

      def self.create_table  database, table_name, primary_keys
        Class.new(database) do
          self.table_name = table_name
          self.primary_keys = primary_keys if primary_keys.length > 1
          self.primary_key = primary_keys[0] if primary_keys.length == 1
          self.mass_assignment_sanitizer = MassAssignmentIgnoreSanitizer.new(self)
        end
      end

    end

    class SourceTable < BaseTable

      def self.create table_name, primary_key
        create_table  SourceDatabase, table_name, primary_key
      end

    end

    class DestinationTable < BaseTable

      def self.create table_name, primary_key
        create_table DestinationDatabase, table_name, primary_key
      end

    end

  end
end
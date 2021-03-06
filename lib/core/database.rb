module DataAnon
  module Core

    class Database

      def initialize name
        @name = name
        @strategy = DataAnon::Strategy::Whitelist
        @user_defaults = {}
      end

      def strategy strategy
        @strategy = strategy
      end

      def source_db connection_spec
        DataAnon::Utils::SourceDatabase.establish_connection connection_spec
      end

      def destination_db connection_spec
        DataAnon::Utils::DestinationDatabase.establish_connection connection_spec
      end

      def default_field_strategies default_strategies
        @user_defaults = default_strategies
      end

      def table (name, &block)
        @strategy.new(name, @user_defaults).process_fields(&block).process
      end


    end

  end
end
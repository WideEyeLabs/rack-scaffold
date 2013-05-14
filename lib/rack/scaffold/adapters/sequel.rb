require 'sequel'
require 'forwardable'

module Rack::Scaffold::Adapters
  class Sequel < Base
    extend Forwardable

    def_delegators :@klass, :count, :all, :find, :[]
    def_delegator :@klass, :create, :create!
    def_delegator :@klass, :update, :update!
    def_delegator :@klass, :destroy, :destroy!

    class << self
      def ===(model)
        ::Sequel::Model === model
      end

      def resources(model)
        model
      end
    end

    def singular
      @klass.name
    end

    def plural
      @klass.table_name
    end

    def paginate(limit, offset)
      @klass.limit(limit, offset)
    end
  end
end

module Cms
  module Attribute
    class Base      
      attr_accessor :name
      attr_reader :type, :key, :klass, :strong_parameter

      def initialize(name, options = {})
        @name = name
        @key = options[:key]
        @klass = options[:klass]
      end

      def type
        self.class.name.demodulize.underscore
      end

      def key
        @key || @name
      end

      def strong_parameter
        @key
      end
    end
  end
end

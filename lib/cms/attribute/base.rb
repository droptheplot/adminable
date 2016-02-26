module Cms
  module Attribute
    class Base
      attr_accessor :name, :klass

      def initialize(name, options = {})
        @name = name
        @klass = options[:klass]
        @key = options[:key]
      end

      def type
        self.class.name.demodulize.underscore
      end

      def key
        @key || @name
      end

      def strong_parameter
        self.key
      end

      def index_partial_path
        "index/#{ self.type }"
      end

      def form_partial_path
        "cms/resources/form/#{ self.type }"
      end

      def center?
        %w(integer boolean).include?(self.type)
      end
    end
  end
end

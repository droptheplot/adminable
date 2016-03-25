module Cms
  module Attribute
    class Base
      attr_accessor :name, :wysiwyg, :center, :show
      attr_reader :key

      alias_method :show?, :show
      alias_method :center?, :center
      alias_method :wysiwyg?, :wysiwyg

      def initialize(name, options = {})
        @name = name
        @key = options[:key] || @name
        @association = options[:association]
        @show = true
        @center = %w(integer boolean).include?(self.type)
        @wysiwyg = %w(text).include?(self.type)
      end

      def type
        self.class.name.demodulize.underscore
      end

      def strong_parameter
        @key
      end

      def index_partial_path
        "index/#{ self.type }"
      end

      def form_partial_path
        "cms/resources/form/#{ self.type }"
      end
    end
  end
end

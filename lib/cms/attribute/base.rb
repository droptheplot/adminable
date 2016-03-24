module Cms
  module Attribute
    class Base
      attr_accessor :name, :wysiwyg, :center, :show

      def initialize(name, options = {})
        @name = name
        @key = options[:key]
        @association = options[:association]
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

      def show
        @show.nil? ? true : @show
      end

      def center
        @center.nil? ? %w(integer boolean).include?(self.type) : @center
      end

      def wysiwyg
        @wysiwyg.nil? ? %w(text).include?(self.type) : @wysiwyg
      end
    end
  end
end

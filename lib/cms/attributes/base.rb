module Cms
  module Attributes
    class Base
      attr_accessor :name, :required, :show, :center, :wysiwyg
      attr_reader :key, :ransack_name

      def initialize(name, options = {})
        raise 'Base class cannot be initialized' if self.class == Base

        @name = name
        @key = options[:key] || @name
        @ransack_name = "#{@name}_cont"
        @association = options[:association]
        @required = options[:required] || false
        @show = true
        @center = %w(integer boolean float decimal).include?(type)
        @wysiwyg = %w(text).include?(type)
      end

      alias required? required
      alias show? show
      alias center? center
      alias wysiwyg? wysiwyg

      def type
        self.class.name.demodulize.underscore
      end

      def strong_parameter
        key
      end

      def index_partial_path
        "index/#{type}"
      end

      def form_partial_path
        "cms/resources/form/#{type}"
      end
    end
  end
end

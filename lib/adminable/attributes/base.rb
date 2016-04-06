module Adminable
  module Attributes
    class Base
      attr_accessor :name, :required, :show, :center, :wysiwyg
      attr_reader :key, :ransack_name, :association

      def initialize(name, options = {})
        raise 'Base class cannot be initialized' if self.class == Base

        @name = name
        @key = options[:key] || @name
        @ransack_name = "#{@name}_cont"
        @required = options[:required] || false
        @show = true
        @center = %w(integer boolean float decimal).include?(type)
        @wysiwyg = %w(text).include?(type)

        if options[:association]
          @association = Adminable::Attributes::Association.new(
            options[:association]
          )
        end
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
        "adminable/resources/form/#{type}"
      end
    end
  end
end

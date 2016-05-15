module Adminable
  module Fields
    # Base class for fields
    # @note Cannot be initialized
    class Base
      # @return [Symbol] field name
      attr_reader :name

      # @return [Hash] default options for field
      attr_reader :options

      # @param name [Symbol] field name e.g. `:id` or `:title`
      # @param options [Hash] options, see {default_options}
      def initialize(name, options = {})
        raise 'Base class cannot be initialized' if self.class == Base

        @name = name.to_sym
        @options = default_options.merge(options)
      end

      # @return [Symbol] field form key
      def key
        @key ||= name
      end

      # @return [Symbol] controller strong parameters key
      def strong_parameter
        @strong_parameter ||= key
      end

      # @return [String] ransack form key
      def ransack_name
        @ransack_name ||= "#{name}_cont"
      end

      # @return [Symbol] field type
      # @example
      #   Adminable::Fields::String.new(:title).type
      #   # => :string
      def type
        @type ||= self.class.name.demodulize.underscore.to_sym
      end

      # @return [String] path to field index partial
      def index_partial_path
        "index/#{type}"
      end

      # @return [String] path to field form partial
      def form_partial_path
        "form/#{type}"
      end

      private

        def default_options
          {
            index: true,
            form: true,
            wysiwyg: false,
            search: false,
            required: false,
            center: %i(integer boolean float decimal).include?(type)
          }
        end
    end
  end
end

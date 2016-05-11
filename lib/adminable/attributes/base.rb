module Adminable
  module Attributes
    # Base class for attributes types
    # @note Cannot be initialized
    class Base
      # @return [Symbol] attribute name
      attr_reader :name

      # @return [Hash] default options for attribute
      attr_reader :options

      # @return [Adminable::Attributes::Association]
      attr_reader :association

      # @param name [Symbol] attribute name e.g. `:id` or `:title`
      # @param options [Hash] options, see {default_options}
      def initialize(name, options = {})
        raise 'Base class cannot be initialized' if self.class == Base

        @name = name.to_sym
        @options = default_options.merge(options)

        @association = Adminable::Attributes::Association.new(
          options[:association]
        ) if options[:association]
      end

      # @return [Symbol] attribute form key
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

      # @return [Symbol] attribute type
      # @example
      #   Adminable::Attributes::Types::String.new(:title).type
      #   # => :string
      def type
        @type ||= self.class.name.demodulize.underscore.to_sym
      end

      # @return [String] path to attribute index partial
      def index_partial_path
        "index/#{type}"
      end

      # @return [String] path to attribute form partial
      def form_partial_path
        "form/#{type}"
      end

      private

        def default_options
          {
            index: %i(belongs_to has_many).exclude?(type),
            form: %i(id created_at updated_at).exclude?(name),
            center: %i(integer boolean float decimal).include?(type),
            wysiwyg: %i(text).include?(type),
            search: false,
            required: false
          }
        end
    end
  end
end

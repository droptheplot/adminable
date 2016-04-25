module Adminable
  module Attributes
    # Base class for attributes types
    # @note Cannot be initialized
    class Base
      attr_reader :name, :options, :key, :strong_parameter, :association

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

      def key
        @key ||= name
      end

      def strong_parameter
        @strong_parameter ||= key
      end

      def ransack_name
        @ransack_name ||= "#{name}_cont"
      end

      # @return [Symbol] class type e.g. `:text` for Adminable::Attributes::Text
      def type
        @type ||= self.class.name.demodulize.underscore.to_sym
      end

      def index_partial_path
        "index/#{type}"
      end

      def form_partial_path
        "adminable/resources/form/#{type}"
      end

      private

        def default_options
          {
            index: %i(belongs_to has_many).exclude?(type),
            search: false,
            form: %i(id created_at updated_at).exclude?(name),
            required: false,
            center: %i(integer boolean float decimal).include?(type),
            wysiwyg: false
          }
        end
    end
  end
end

module Adminable
  module Attributes
    class Base
      attr_accessor(
        *%i(
          name
          index
          ransack
          ransack_name
          form
          required
          center
          wysiwyg
        )
      )
      attr_reader :key, :association

      # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
      def initialize(name, options = {})
        raise 'Base class cannot be initialized' if self.class == Base

        @name = name.to_sym
        @key = options.fetch(:key, nil)
        @ransack_name = "#{@name}_cont"

        @index = options.fetch(:index, true)
        @ransack = options.fetch(:ransack, false)
        @form = options.fetch(
          :form,
          %i(id created_at updated_at).exclude?(name)
        )

        @required = options.fetch(:required, false)
        @wysiwyg = options.fetch(:wysiwyg, (type == 'text'))
        @center = options.fetch(
          :center,
          %w(integer boolean float decimal).include?(type)
        )

        if options[:association]
          @association = Adminable::Attributes::Association.new(
            options[:association]
          )
        end
      end

      alias index? index
      alias form? form
      alias ransack? ransack
      alias required? required
      alias wysiwyg? wysiwyg
      alias center? center

      def key
        @key ||= name
      end

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

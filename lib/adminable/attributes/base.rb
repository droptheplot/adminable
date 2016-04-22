module Adminable
  module Attributes
    # Base class for attributes types
    # @note Cannot be initialized
    class Base
      OPTIONS_NAMES = %i(
        index
        search
        ransack_name
        form
        required
        center
        nowrap
        wysiwyg
      ).freeze

      attr_accessor :name, *OPTIONS_NAMES
      attr_reader :key, :strong_parameter, :association

      # @param name [Symbol] attribute name e.g. `:id` or `:title`
      # @param options [Hash] options, see {OPTIONS_NAMES}
      #
      # rubocop:disable Metrics/MethodLength
      def initialize(name, options = {})
        raise 'Base class cannot be initialized' if self.class == Base

        @name = name.to_sym
        @strong_parameter = @key = options.fetch(:key, @name)

        @association = Adminable::Attributes::Association.new(
          options[:association]
        ) if options[:association]
      end

      def index
        return @index unless @index.nil?
        @index = true
      end
      alias index? index

      def form
        return @form unless @form.nil?
        @form = %i(id created_at updated_at).exclude?(@name)
      end
      alias form? form

      def search
        return @search unless @search.nil?
        @search = false
      end
      alias search? search

      def required
        return @required unless @required.nil?
        @required = false
      end
      alias required? required

      def wysiwyg
        return @wysiwyg unless @wysiwyg.nil?
        @wysiwyg = (type == :text)
      end
      alias wysiwyg? wysiwyg

      def center
        return @center unless @center.nil?
        @center = %i(integer boolean float decimal).include?(type)
      end
      alias center? center

      def nowrap
        return @nowrap unless @nowrap.nil?
        @nowrap = %i(
          integer
          boolean
          float
          decimal
          date
          datetime
          time
          timestamp
        ).include?(type)
      end
      alias nowrap? nowrap

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
    end
  end
end

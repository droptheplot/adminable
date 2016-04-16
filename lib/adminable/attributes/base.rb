module Adminable
  module Attributes
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
      attr_reader :key, :association

      # rubocop:disable Metrics/MethodLength
      def initialize(name, options = {})
        raise 'Base class cannot be initialized' if self.class == Base

        @name = name.to_sym
        @key = options.fetch(:key, nil)

        OPTIONS_NAMES.each do |option_name|
          instance_variable_set("@#{option_name}", options[option_name])
        end

        if options[:association]
          @association = Adminable::Attributes::Association.new(
            options[:association]
          )
        end
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
        @wysiwyg = (type == 'text')
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

      def key
        @key ||= name
      end

      def type
        @type ||= self.class.name.demodulize.underscore.to_sym
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

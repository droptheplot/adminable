module Cms
  class Resource
    attr_reader :name, :model
    attr_writer :attributes

    def initialize(name)
      @name = name
      @model = name.classify.constantize

      load_extensions
    end

    def route
      @route ||= @model.name.underscore.pluralize.tr('/', '_')
    end

    def includes
      @includes ||= if attributes.association.present?
        attributes.association.map { |k, v| v.name }
      else
        false
      end
    end

    def attributes
      @attributes ||= Cms::Attributes::Collection.new(@model)
    end

    private

      def load_extensions
        if @model.method_defined?(:devise_modules)
          attributes.extend(Cms::Extensions::Devise)
        end
      end
  end
end

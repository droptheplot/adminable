module Adminable
  class Resource
    attr_reader :name, :model
    attr_writer :attributes

    # @param name [String] resource name, usually same as the model name
    def initialize(name)
      @name = name
      @model = name.classify.constantize
    end

    # @return [String] for route helper name
    def route
      @route ||= @model.name.underscore.pluralize.tr('/', '_')
    end

    # @return [Array] of associations names for ActiveRecord queries
    def includes
      @includes ||= if attributes.associations.present?
                      attributes.associations.map(&:name)
                    else
                      false
                    end
    end

    # @return [Array] collection, see {Adminable::Attributes::Collection}
    def attributes
      @attributes ||= Adminable::Attributes::Collection.new(@model)
    end
  end
end

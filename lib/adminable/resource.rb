module Adminable
  class Resource
    include Comparable

    attr_reader :name, :model, :fields

    # @param name [String] resource name, usually same as the model name
    def initialize(name)
      @name = name
      @model = name.classify.constantize
    end

    # @return [String] for route helper name
    def route
      @route ||= @model.name.underscore.pluralize.tr('/', '_')
    end

    def <=>(other)
      other.is_a?(Adminable::Resource) && name <=> other.name
    end
  end
end

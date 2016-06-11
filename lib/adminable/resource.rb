module Adminable
  class Resource
    include Comparable

    attr_reader :name, :model, :fields

    # @param name [String, ActiveRecord::Base] name of/or ActiveRecord class
    def initialize(name)
      @name = name
      @model = name.to_s.classify.constantize
    end

    # @return [String] for route helper name
    def route
      @route ||= @model.name.underscore.pluralize.tr('/', '_')
    end

    def human
      i18n_key = "activerecord.models.#{@model.model_name.i18n_key}"

      if I18n.exists?(i18n_key)
        @model.model_name.human(count: 2)
      else
        @model.model_name.name.gsub('::', ' ').pluralize
      end
    end

    def <=>(other)
      other.is_a?(Adminable::Resource) && name <=> other.name
    end
  end
end

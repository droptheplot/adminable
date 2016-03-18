module Cms
  class Resource
    attr_accessor :model, :attributes, :index_attributes, :form_attributes

    def initialize(model)
      @model = model
    end

    def title
      @model.model_name.human.pluralize
    end

    def index_attributes
      @index_attributes ||= self.attributes
        .except(:created_at, :updated_at)
    end

    def form_attributes
      @form_attributes ||= self.attributes
        .except(:id, :created_at, :updated_at)
    end

    def attributes
      @attributes ||= Hash.new.tap do |attribute|
        @model.columns.reject{ |a| a.name.match(/_id$/) }.each do |column|
          attribute[column.name] = "cms/attribute/#{ column.type }"
            .classify.constantize.new(column.name)
        end

        @model.reflect_on_all_associations(:belongs_to).map do |association|
          attribute[association.name] = Cms::Attribute::BelongsTo.new(
            association.name,
            association: association
          )
        end

        @model.reflect_on_all_associations(:has_many).map do |association|
          attribute[association.name] = Cms::Attribute::HasMany.new(
            association.name,
            association: association
          )
        end
      end.symbolize_keys
    end
  end
end

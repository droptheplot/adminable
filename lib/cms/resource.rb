module Cms
  class Resource
    attr_reader :name, :model
    attr_writer :index_attributes, :form_attributes

    def initialize(name)
      @name = name
      @model = name.classify.constantize

      load_extensions
    end

    def route
      @route ||= @model.name.underscore.pluralize.tr('/', '_')
    end

    def includes
      @includes ||= if association_attributes.present?
        association_attributes.map(&:name)
      else
        false
      end
    end

    def index_attributes
      @index_attributes ||= attributes.except(:created_at, :updated_at)
    end

    def form_attributes
      @form_attributes ||= attributes.except(:id, :created_at, :updated_at)
    end

    def attributes
      @attributes ||= {}.tap do |attribute|
        columns_attributes.each do |column|
          attribute[column.name] = "cms/attributes/types/#{column.type}"
            .classify.constantize.new(
              column.name,
              required: attribute_required?(column.name)
            )
        end

        belongs_to_attributes.each do |association|
          attribute[association.name] = Cms::Attributes::Types::BelongsTo.new(
            association.name,
            required: attribute_required?(association.name),
            association: association
          )
        end

        has_many_attributes.each do |association|
          attribute[association.name] = Cms::Attributes::Types::HasMany.new(
            association.name,
            required: attribute_required?(association.name),
            association: association
          )
        end
      end.symbolize_keys
    end

    private

      def columns_attributes
        @model.columns.reject { |a| a.name.match(/_id$/) }
      end

      def belongs_to_attributes
        @model.reflect_on_all_associations(:belongs_to)
      end

      def has_many_attributes
        @model.reflect_on_all_associations(:has_many)
      end

      def association_attributes
        belongs_to_attributes.concat(has_many_attributes)
      end

      def attribute_required?(name)
        @model.validators_on(name).any? do |validator|
          validator.class == ActiveRecord::Validations::PresenceValidator
        end
      end

      def load_extensions
        if @model.method_defined?(:devise_modules)
          extend Cms::Extensions::Devise
        end
      end
  end
end

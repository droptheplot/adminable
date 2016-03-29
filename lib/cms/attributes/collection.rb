module Cms
  module Attributes
    class Collection
      attr_reader :model
      attr_writer :index, :form

      def initialize(model)
        @model = model
      end

      def index
        @index ||= all.except(:created_at, :updated_at)
      end

      def form
        @form ||= all.except(:id, :created_at, :updated_at)
      end

      def ransack
        @ransack ||= columns.except(:id, :created_at, :updated_at)
                            .select { |k, v| %w(string text).include?(v.type) }
      end

      def all
        [columns, belongs_to, has_many].inject(&:merge)
      end

      def association
        [belongs_to, has_many].inject(&:merge)
      end

      def columns
        @columns ||= {}.tap do |attribute|
          @model.columns.reject { |a| a.name.match(/_id$/) }.each do |column|
            attribute[column.name] = "cms/attributes/types/#{column.type}"
              .classify.constantize.new(
                column.name,
                required: attribute_required?(column.name)
              )
          end
        end.symbolize_keys
      end

      def belongs_to
        @belongs_to ||= {}.tap do |attribute|
          @model.reflect_on_all_associations(:belongs_to).each do |association|
            attribute[association.name] = Cms::Attributes::Types::BelongsTo.new(
              association.name,
              required: attribute_required?(association.name),
              association: association
            )
          end
        end.symbolize_keys
      end

      def has_many
        @has_many ||= {}.tap do |attribute|
          @model.reflect_on_all_associations(:has_many).each do |association|
            attribute[association.name] = Cms::Attributes::Types::HasMany.new(
              association.name,
              required: attribute_required?(association.name),
              association: association
            )
          end
        end.symbolize_keys
      end

      private

        def attribute_required?(name)
          @model.validators_on(name).any? do |validator|
            validator.class == ActiveRecord::Validations::PresenceValidator
          end
        end
    end
  end
end

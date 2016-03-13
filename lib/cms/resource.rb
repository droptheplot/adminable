module Cms
  module Resource
    def self.extended(mod)
      class << mod
        attr_accessor :attributes_for_index, :attributes_for_form

        def attributes_for_index
          @attributes_for_index ||= self.collect_attributes
            .except(:created_at, :updated_at)
        end

        def attributes_for_form
          @attributes_for_form ||= self.collect_attributes
            .except(:id, :created_at, :updated_at)
        end

        def collect_attributes
          attributes = {}

          self.columns.reject{ |a| a.name.match(/_id$/) }.each do |column|
            attributes[column.name] = "cms/attribute/#{ column.type }"
              .classify.constantize.new(column.name)
          end

          self.reflect_on_all_associations(:belongs_to).map do |association|
            attributes[association.name] = Cms::Attribute::BelongsTo.new(
              association.name,
              association: association
            )
          end

          self.reflect_on_all_associations(:has_many).map do |association|
            attributes[association.name] = Cms::Attribute::HasMany.new(
              association.name,
              association: association
            )
          end

          attributes.symbolize_keys
        end
      end
    end
  end
end

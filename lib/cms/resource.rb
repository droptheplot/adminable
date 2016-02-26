module Cms
  module Resource
    def collect_attributes
      attributes = []

      attributes += self.columns.reject do |attribute|
        attribute.name.match(/_id$/)
      end.map do |column|
        "cms/attribute/#{ column.type }".classify.constantize.new(column.name)
      end

      attributes += self.reflect_on_all_associations(:belongs_to).map do |association|
        Cms::Attribute::BelongsTo.new(
          association.name,
          key: association.foreign_key,
          klass: association.klass
        )
      end

      attributes += self.reflect_on_all_associations(:has_many).map do |association|
        Cms::Attribute::HasMany.new(
          association.name,
          key: association.foreign_key,
          klass: association.klass
        )
      end

      attributes
    end
  end
end

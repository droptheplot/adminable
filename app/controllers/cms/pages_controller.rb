module Cms
  class PagesController < ResourcesController
    private

      def columns_for_list
        @columns_for_list = @resource.columns.select do |column|
          %w(id title slug body created_at updated_at).include?(column.name)
        end
      end

      def resource_model
        Cms::Page
      end
  end
end

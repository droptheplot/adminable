require 'rails/generators/base'

module Adminable
  module Generators
    class PartialGenerator < Rails::Generators::Base
      source_root Adminable::Engine.root.join('app/views/adminable/resources')

      argument :layout, type: :string, default: 'index'
      argument :type, type: :string, default: 'string'
      argument :resource, type: :string, default: 'resources'

      def copy_partial
        template(
          File.join(partial_path),
          File.join('app/views/adminable', resource, partial_path)
        )
      end

      private

        def partial_path
          File.join(layout, "_#{type}.html.haml")
        end
    end
  end
end

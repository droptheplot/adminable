module Cms
  module Configuration
    def self.resources
      resources_paths.map do |resource_path|
        resource = resource_path.to_s.split('cms/').last.sub(/_controller\.rb$/, '')

        {
          name: resource.tr('/', '_'),
          path: resource
        }
      end
    end

    def self.resources_paths
      Dir[Rails.root.join('app/controllers/cms/**/*_controller.rb')] <<
      Cms::Engine.root.join('app/controllers/cms/pages_controller.rb')
    end
  end
end

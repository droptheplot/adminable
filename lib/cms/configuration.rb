module Cms
  module Configuration
    def self.resources
      @resources ||= resources_paths.map do |resource_path|
        model = resource_path.to_s.split('cms/').last.sub(/_controller\.rb$/, '')
        Cms::Resource.new(model)
      end
    end

    def self.find_resource(klass)
      @resources.find{ |obj| obj.model == klass }
    end

    def self.resources_paths
      Dir[Rails.root.join('app/controllers/cms/**/*_controller.rb')]
    end
  end
end

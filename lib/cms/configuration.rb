module Cms
  module Configuration
    def self.resources_names
      resources_paths.map do |resource_path|
        Pathname.new(resource_path).sub_ext('').each_filename.to_a
          .split{ |file| file === 'cms' }.last.join('/').sub(/_controller$/, '')
      end
    end

    def self.resources_paths
      Dir[Rails.root.join('app/controllers/cms/*_controller.rb')] <<
      Cms::Engine.root.join('app/controllers/cms/pages_controller.rb')
    end
  end
end

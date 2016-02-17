module Cms
  class Engine < ::Rails::Engine
    isolate_namespace Cms

    ActionDispatch::Reloader.to_prepare do
      require_dependency Cms::Engine.root.join('app/controllers/cms/resources_controller.rb')
    end
  end
end

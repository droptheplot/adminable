module Adminable
  class Engine < ::Rails::Engine
    isolate_namespace Adminable

    ActionDispatch::Reloader.to_prepare do
      require_dependency(
        Adminable::Engine.root.join(
          'app/controllers/adminable/resources_controller.rb'
        )
      )
    end
  end
end

module Adminable
  class BasePresenter
    include Adminable::Engine.routes.url_helpers

    private

      def view
        ActionController::Base.helpers
      end
  end
end

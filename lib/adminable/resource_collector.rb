module Adminable
  class ResourceCollector
    def initialize(paths)
      @paths = paths
    end

    # Finds all controllers from `app/controllers/adminable` directory
    # @return [Array] of {Adminable::Resource} objects
    def resources
      @paths.map do |resource_path|
        Adminable::Resource.new(
          resource_path.to_s.split('adminable/').last.sub(
            /_controller\.rb$/, ''
          )
        )
      end
    end
  end
end

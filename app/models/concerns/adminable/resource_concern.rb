module Adminable
  module ResourceConcern
    extend ActiveSupport::Concern

    def adminable_name
      %i(title name email login id).each do |n|
        return try(n) unless try(n).nil?
      end
    end
  end
end

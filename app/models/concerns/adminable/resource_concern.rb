module Adminable
  module ResourceConcern
    extend ActiveSupport::Concern

    def adminable_name
      %i(title name email login id).each do |n|
        return self.try(n) unless self.try(n).nil?
      end
    end
  end
end

module Adminable
  module ResourceConcern
    extend ActiveSupport::Concern

    def adminable
      %i(title name email login id).each do |name|
        return OpenStruct.new(name: public_send(name)) unless try(name).nil?
      end
    end
  end
end

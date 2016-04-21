module Adminable
  module ResourceConcern
    extend ActiveSupport::Concern

    def adminable
      %i(title name email login id).each do |name|
        begin
          return OpenStruct.new(name: public_send(name))
        rescue NoMethodError
          next
        end
      end
    end
  end
end

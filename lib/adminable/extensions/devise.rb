module Adminable
  module Extensions
    module Devise
      def self.included(mod)
        mod.attributes_for :index do |attributes|
          attributes.except!(:encrypted_password)
        end

        mod.attributes_for :form do |attributes|
          attributes.except!(:encrypted_password)
          attributes[:password] = Adminable::Attributes::Types::String.new(
            :password
          )
        end

        mod.attributes_for :ransack do |attributes|
          attributes.except!(:encrypted_password)
        end
      end
    end
  end
end

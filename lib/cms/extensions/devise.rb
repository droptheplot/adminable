module Cms
  module Extensions
    module Devise
      def index_attributes
        super.except!(:encrypted_password)
        super
      end

      def form_attributes
        super.except!(:encrypted_password)
        super[:password] = Cms::Attributes::Types::String.new(:password)
        super
      end
    end
  end
end

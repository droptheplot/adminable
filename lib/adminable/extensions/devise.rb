module Adminable
  module Extensions
    module Devise
      def index
        super.except!(:encrypted_password)

        @index ||= super
      end

      def form
        super.except!(:encrypted_password)
        super[:password] = Adminable::Attributes::Types::String.new(:password)

        @form ||= super
      end

      def ransack
        super.except!(:encrypted_password)

        @ransack ||= super
      end
    end
  end
end

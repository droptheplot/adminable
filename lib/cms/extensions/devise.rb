module Cms
  module Extensions
    module Devise
      def index
        super.except!(:encrypted_password)

        @index ||= super
      end

      def form
        super.except!(:encrypted_password)
        super[:password] = Cms::Attributes::Types::String.new(:password)

        @form ||= super
      end
    end
  end
end

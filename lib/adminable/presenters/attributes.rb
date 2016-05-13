module Adminable
  module Presenters
    class Attributes < SimpleDelegator
      def index
        select { |attribute| attribute.options[:index] }
      end

      def form
        select { |attribute| attribute.options[:form] }
      end

      def search
        select { |attribute| attribute.options[:search] }
      end
    end
  end
end

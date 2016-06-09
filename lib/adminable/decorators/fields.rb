module Adminable
  module Decorators
    class Fields < DelegateClass(Array)
      def index
        select { |field| field.options[:index] }
      end

      def form
        select { |field| field.options[:form] }
      end

      def search
        select { |field| field.options[:search] }
      end
    end
  end
end

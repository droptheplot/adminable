module Adminable
  module Presenters
    class Fields < SimpleDelegator
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

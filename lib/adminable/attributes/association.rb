module Adminable
  module Attributes
    module Association
      attr_reader :options_for_select, :association

      def options_for_select(entry)
        @association.klass.all.reject { |e| e == entry }.collect do |e|
          [association_option_name(e), e.id]
        end
      end

      private

        def association_option_name(entry)
          %i(email login name title id).each do |a|
            return entry.try(a) unless entry.try(a).nil?
          end
        end
    end
  end
end

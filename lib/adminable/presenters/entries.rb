module Adminable
  module Presenters
    class Entries < Base
      ENTRIES_LIMIT = 5

      include Enumerable
      extend Forwardable

      def_delegators :@collection, :each, :first, :last, :empty?
      def_delegators(
        *%i(
          @relation
          current_page
          total_pages
          limit_value
          entry_name
          total_count
          offset_value
          last_page?
        )
      )

      def initialize(relation)
        @relation = relation
        @collection = relation.all.map do |entry|
          Adminable::Presenters::Entry.new(entry)
        end
      end

      def to_s
        string = collection.first(ENTRIES_LIMIT).map do |entry|
          view.link_to(entry.to_name, edit_polymorphic_path(entry))
        end

        string << and_more_tag if collection_size_residue > 0

        string.join(', ').html_safe
      end

      private

        attr_accessor :relation, :collection

        def collection_size_residue
          @collection_residue ||= collection.size - ENTRIES_LIMIT
        end

        def and_more_tag
          view.content_tag(
            :span,
            I18n.t('adminable.ui.and_more', size: collection_size_residue),
            class: 'text-muted'
          )
        end
    end
  end
end

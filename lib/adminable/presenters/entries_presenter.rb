module Adminable
  class EntriesPresenter < BasePresenter
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
        Adminable::EntryPresenter.new(entry)
      end
    end

    def to_s
      string = collection.first(ENTRIES_LIMIT).map do |entry|
        view.link_to(entry.to_name, edit_polymorphic_path(entry))
      end

      if collection_size_residue > 0
        string << I18n.t('adminable.ui.and_more', size: collection_size_residue)
      end

      string.join(', ').html_safe
    end

    private

      attr_accessor :relation, :collection

      def collection_size_residue
        @collection_residue ||= collection.size - ENTRIES_LIMIT
      end
  end
end

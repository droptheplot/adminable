module Cms
  class Page < ApplicationRecord
    belongs_to :superpage, class_name: 'Cms::Page', foreign_key: :cms_page_id, required: false
    has_many :subpages, class_name: 'Cms::Page', foreign_key: :cms_page_id

    before_save :set_slug

    scope :orphans, -> { where(contents_page_id: nil) }

    def path
      path = [self.slug]
      page = self

      while page.superpage do
        path << page.superpage.slug
        page = page.superpage
      end

      path.reverse.join('/')
    end

    def layout
      self[:layout] || 'application'
    end

    def template
      self[:template] || 'application/index'
    end

    private

      def set_slug
        self.slug = self.title.to_slug.transliterate.normalize unless self.slug
      end
  end
end

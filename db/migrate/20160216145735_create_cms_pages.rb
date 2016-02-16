class CreateCmsPages < ActiveRecord::Migration[5.0]
  def change
    create_table :cms_pages do |t|
      t.string :title
      t.string :slug
      t.string :description
      t.string :keywords
      t.references :cms_page, index: true, foreign_key: true
      t.text :body
      t.string :layout
      t.string :template

      t.timestamps null: false
    end

    add_index :cms_pages, :slug
    add_index :cms_pages, :layout
    add_index :cms_pages, :template
  end
end

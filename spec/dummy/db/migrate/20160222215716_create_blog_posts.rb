class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :body
      t.references :user, foreign_key: true
      t.boolean :published
      t.float :rating

      t.timestamps
    end
  end
end

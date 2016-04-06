class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :body
      t.references :user, foreign_key: true
      t.boolean :published
      t.integer :comments_count

      t.timestamps
    end
  end
end

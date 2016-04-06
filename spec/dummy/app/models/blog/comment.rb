module Blog
  class Comment < ApplicationRecord
    belongs_to :blog_post, class_name: 'Blog::Post', foreign_key: 'blog_post_id'
    belongs_to :user
  end
end

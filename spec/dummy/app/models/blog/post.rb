module Blog
  class Post < ApplicationRecord
    belongs_to :user, required: false
    has_many :blog_comments, class_name: 'Blog::Comment', foreign_key: 'blog_post_id'

    validates :title, presence: true
  end
end

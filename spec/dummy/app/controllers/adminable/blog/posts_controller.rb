class Adminable::Blog::PostsController < Adminable::ResourcesController
  def fields
    [
      Adminable::Fields::String.new(:title),
      Adminable::Fields::Text.new(:body),
      Adminable::Fields::HasMany.new(:blog_comments),
      Adminable::Fields::BelongsTo.new(:user)
    ]
  end
end

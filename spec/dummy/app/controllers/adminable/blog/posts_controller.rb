class Adminable::Blog::PostsController < Adminable::ResourcesController
  def attributes
    [
      Adminable::Attributes::Types::String.new(:title),
      Adminable::Attributes::Types::Text.new(:body),
      Adminable::Attributes::Types::HasMany.new(:blog_comments),
      Adminable::Attributes::Types::BelongsTo.new(:user)
    ]
  end
end

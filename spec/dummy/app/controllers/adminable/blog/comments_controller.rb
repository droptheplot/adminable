class Adminable::Blog::CommentsController < Adminable::ResourcesController
  def attributes
    [
      Adminable::Attributes::Types::Text.new(:body),
      Adminable::Attributes::Types::BelongsTo.new(:blog_post),
      Adminable::Attributes::Types::BelongsTo.new(:user)
    ]
  end
end

class Adminable::Blog::CommentsController < Adminable::ResourcesController
  def fields
    [
      Adminable::Fields::Text.new(:body),
      Adminable::Fields::BelongsTo.new(:blog_post),
      Adminable::Fields::BelongsTo.new(:user)
    ]
  end
end

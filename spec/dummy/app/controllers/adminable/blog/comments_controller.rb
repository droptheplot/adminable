class Adminable::Blog::CommentsController < Adminable::ResourcesController
  def fields
    [
      Adminable::Fields::Integer.new(:id, form: false),
      Adminable::Fields::Text.new(:body, wysiwyg: true),
      Adminable::Fields::BelongsTo.new(:blog_post),
      Adminable::Fields::BelongsTo.new(:user)
    ]
  end
end

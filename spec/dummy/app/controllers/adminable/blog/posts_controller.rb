class Adminable::Blog::PostsController < Adminable::ResourcesController
  def fields
    [
      Adminable::Fields::Integer.new(:id, form: false),
      Adminable::Fields::String.new(:title),
      Adminable::Fields::Text.new(:body, wysiwyg: true),
      Adminable::Fields::Float.new(:rating),
      Adminable::Fields::Boolean.new(:published),
      Adminable::Fields::BelongsTo.new(:user),
      Adminable::Fields::HasMany.new(:blog_comments)
    ]
  end
end

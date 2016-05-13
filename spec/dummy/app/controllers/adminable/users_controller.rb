class Adminable::UsersController < Adminable::ResourcesController
  def attributes
    [
      Adminable::Attributes::Types::String.new(:email),
      Adminable::Attributes::Types::Datetime.new(:created_at),
      Adminable::Attributes::Types::HasMany.new(:blog_posts),
      Adminable::Attributes::Types::HasMany.new(:blog_comments)
    ]
  end

  def update
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    super
  end
end

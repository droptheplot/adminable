class Adminable::UsersController < Adminable::ResourcesController
  def fields
    [
      Adminable::Fields::Integer.new(:id, form: false),
      Adminable::Fields::String.new(:email),
      Adminable::Fields::HasMany.new(:blog_posts),
      Adminable::Fields::HasMany.new(:blog_comments),
      Adminable::Fields::Datetime.new(:created_at, form: false),
      Adminable::Fields::String.new(:password, index: false),
      Adminable::Fields::HasOne.new(:profile)
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

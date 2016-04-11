class Adminable::Blog::PostsController < Adminable::ResourcesController
  set_attributes do |attributes|
    attributes.set :created_at, index: false, form: false
    attributes.set :updated_at, index: false, form: false
  end
end

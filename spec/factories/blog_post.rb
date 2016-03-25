FactoryGirl.define do
  factory :blog_post, class: Blog::Post do
    title 'Title'
    body 'Body'
    user
  end
end

FactoryGirl.define do
  factory :blog_post, class: Blog::Post do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.sentences }
    user
  end
end

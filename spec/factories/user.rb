FactoryGirl.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password 'password'
  end
end

10.times do
  user = User.create(
    email: Faker::Internet.safe_email,
    password: Faker::Internet.password,
    created_at: Faker::Time.backward(90, :all),
    updated_at: Faker::Time.backward(90, :all)
  )

  blog_post = Blog::Post.create(
    title: Faker::Hipster.word.titleize,
    body: Faker::Hipster.sentence,
    published: Faker::Boolean.boolean,
    rating: rand.round(1),
    user_id: user.id,
    created_at: Faker::Time.backward(90, :all),
    updated_at: Faker::Time.backward(90, :all)
  )

  rand(10).times do
    Blog::Comment.create(
      body: Faker::Hipster.paragraph(3),
      user_id: user.id,
      blog_post_id: blog_post.id,
      created_at: Faker::Time.backward(90, :all),
      updated_at: Faker::Time.backward(90, :all)
    )
  end
end

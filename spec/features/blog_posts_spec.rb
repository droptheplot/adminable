feature 'Blog Posts' do
  scenario 'user create blog post' do
    user = FactoryGirl.create(:user)

    visit(new_blog_post_path)

    expect(page.status_code).to eq(200)

    fill_in(:blog_post_title, with: 'New Post Title')
    fill_in(:blog_post_body, with: 'New Post Body')
    select(user.email, from: :blog_post_user_id)

    click_button('Submit')

    expect(page.current_path).to eq(blog_posts_path)
    expect(page).to have_content('New Post Title')
    expect(page).to have_content('New Post Body')
    expect(page).to have_content(
      I18n.t('cms.resources.created', resource: 'Post')
    )
  end

  scenario 'user update blog post' do
    blog_post = FactoryGirl.create(:blog_post)

    visit(edit_blog_post_path(blog_post))

    expect(page.status_code).to eq(200)

    fill_in(:blog_post_title, with: 'Another Post Title')
    fill_in(:blog_post_body, with: 'Another Post Body')

    click_button('Submit')

    expect(page.current_path).to eq(blog_posts_path)
    expect(page).to have_content('Another Post Title')
    expect(page).to have_content('Another Post Body')
    expect(page).to have_content(
      I18n.t('cms.resources.updated', resource: 'Post')
    )
  end

  scenario 'user delete blog post' do
    blog_post = FactoryGirl.create(:blog_post)

    visit(blog_posts_path)

    expect(page.status_code).to eq(200)

    click_link('Delete')

    expect(page.current_path).to eq(blog_posts_path)
    expect(page).to have_content(
      I18n.t('cms.resources.deleted', resource: 'Post')
    )
  end
end

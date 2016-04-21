feature 'Blog Posts' do
  feature 'user creates blog post' do

    before do
      FactoryGirl.create(:user)
      visit(new_blog_post_path)
      expect(page.status_code).to eq(200)
    end

    scenario 'with required fields' do
      fill_in(:blog_post_title, with: 'New Post Title')
      fill_in(:blog_post_body, with: 'New Post Body')
      choose('blog_post_user_id_1')

      click_button('Submit')

      expect(page.current_path).to eq(blog_posts_path)
      expect(page).to have_content('New Post Title')
      expect(page).to have_content('New Post Body')
      expect(page).to have_content(
        I18n.t('adminable.resources.created', resource: 'Post')
      )
    end

    scenario 'without required fields' do
      click_button('Submit')

      expect(page.current_path).to eq(blog_posts_path)
      expect(page).to have_content("Title can't be blank")
    end
  end

  feature 'user updates blog post' do
    before do
      blog_post = FactoryGirl.create(:blog_post)
      visit(edit_blog_post_path(blog_post))
      expect(page.status_code).to eq(200)
    end

    scenario 'with required fields' do
      fill_in(:blog_post_title, with: 'Another Post Title')
      fill_in(:blog_post_body, with: 'Another Post Body')

      click_button('Submit')

      expect(page.current_path).to eq(blog_posts_path)
      expect(page).to have_content('Another Post Title')
      expect(page).to have_content('Another Post Body')
      expect(page).to have_content(
        I18n.t('adminable.resources.updated', resource: 'Post')
      )
    end

    scenario 'without required fields' do
      fill_in(:blog_post_title, with: '')

      click_button('Submit')

      expect(page).to have_content("Title can't be blank")
    end
  end

  scenario 'user delete blog post' do
    FactoryGirl.create(:blog_post)

    visit(blog_posts_path)

    expect(page.status_code).to eq(200)

    click_link('Delete')

    expect(page.current_path).to eq(blog_posts_path)
    expect(page).to have_content(
      I18n.t('adminable.resources.deleted', resource: 'Post')
    )
  end
end

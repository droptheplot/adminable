feature 'Pages' do
  scenario 'user create page' do
    visit(new_page_path)

    expect(page.status_code).to eq(200)

    fill_in(:page_title, with: 'New Page Title')
    fill_in(:page_body, with: 'New Page Body')

    click_button('Submit')

    expect(page.current_path).to eq(pages_path)
    expect(page).to have_content('New Page Title')
    expect(page).to have_content('New Page Body')
    expect(page).to have_content('Successfully Created.')
  end

  scenario 'user update page' do
    cms_page = FactoryGirl.create(:page)

    visit(edit_page_path(cms_page))

    expect(page.status_code).to eq(200)

    fill_in(:page_title, with: 'Another Page Title')
    fill_in(:page_body, with: 'Another Page Body')

    click_button('Submit')

    expect(page.current_path).to eq(pages_path)
    expect(page).to have_content('Another Page Title')
    expect(page).to have_content('Another Page Body')
    expect(page).to have_content('Successfully Updated.')
  end

  scenario 'user delete page' do
    cms_page = FactoryGirl.create(:page)

    visit(pages_path)

    expect(page.status_code).to eq(200)

    click_link('Delete')

    expect(page.current_path).to eq(pages_path)
    expect(page).to have_content('Successfully Destroyed.')
  end
end

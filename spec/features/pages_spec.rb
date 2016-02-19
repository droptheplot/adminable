describe 'Pages', type: :feature do
  let!(:cms_page) { FactoryGirl.create(:page) }

  it 'index page should return status 200' do
    visit pages_path

    expect(page.status_code).to eq(200)
    expect(page).to have_content(cms_page.title)
  end

  it 'edit page should return status 200' do
    visit edit_page_path(cms_page)

    expect(page.status_code).to eq(200)
    expect(page).to have_content(cms_page.title)
  end

  it 'new page should return status 200' do
    visit new_page_path

    expect(page.status_code).to eq(200)
  end
end

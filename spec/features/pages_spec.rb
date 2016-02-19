require 'spec_helper'

describe 'Pages', type: :feature do
  it 'index page should return status 200' do
    visit pages_path

    expect(page.status_code).to eq(200)
  end
end

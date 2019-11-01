require 'rails_helper'

describe "New author page", type: :feature do
  before do
    @author = FactoryBot.create :author
  end

  it "should render withour error" do
    visit edit_author_path(@author)
  end

  it "should save changes to author in the database" do
    visit edit_author_path(@author)
    page.fill_in 'author[first_name]', with: 'FirstName'
    page.fill_in 'author[last_name]', with: 'LastName'
    page.fill_in 'author[homepage]', with: 'https://adrianjost.dev'
    find('input[type="submit"]').click
    @author.reload
    expect(@author.first_name).to eq('FirstName')
    expect(@author.last_name).to eq('LastName')
    expect(@author.homepage).to eq('https://adrianjost.dev')
  end

  it "should show validation errors" do
    visit edit_author_path(@author)
    page.fill_in 'author[last_name]', with: ''
    find('input[type="submit"]').click
    expect(page).to have_text('Last name can\'t be blank')
  end

  it "should have back button" do
    visit edit_author_path(@author)
    expect(page).to have_css("a[href='#{authors_path}']")
  end
end
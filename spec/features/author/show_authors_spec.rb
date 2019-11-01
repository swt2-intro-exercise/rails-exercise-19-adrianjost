require 'rails_helper'

describe "Show author page", type: :feature do
  before do
    @author = FactoryBot.create :author
  end

  it "should render withour error" do
    visit author_path(@author)
  end

  it "should have some text" do
    visit author_path(@author)
    expect(page).to have_text(@author.name)
  end

  it "should link to author edit" do
    visit author_path(@author)
    expect(page).to have_link(href: edit_author_path(@author))
  end

  it "should show a delete link" do
    visit author_path(@author)
    expect(page).to have_css("a[data-method='delete'][href='#{author_path(@author)}']")
  end

  it "should destroy the author" do
    visit author_path(@author)
    @authorsBefore = Author.count
    page.driver.submit :delete, author_path(@author), {}
    expect(Author.exists?(@author.id)).to be false
    expect(@authorsBefore - Author.count).to be 1
  end
end
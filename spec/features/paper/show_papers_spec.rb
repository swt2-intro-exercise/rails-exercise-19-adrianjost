require 'rails_helper'

describe "show papers page", type: :feature do
  before do
    @paper = FactoryBot.create :paper
  end

  it "should render withour error" do
    visit paper_path(@paper)
  end

  it "should display title" do
    visit paper_path(@paper)
    expect(page).to have_text(@paper.title)
  end

  it "doesn't shows the author if there are none" do
    @paperWithoutAuthor = FactoryBot.create :paper_without_author
    visit paper_path(@paperWithoutAuthor)
    expect(@paperWithoutAuthor.authors.count).to be 0
    expect(page).not_to have_text("Author")
  end

  it "shows the author if there is one" do
    visit paper_path(@paper)
    expect(@paper.authors.count).to be 1
    expect(page).to have_text("Author:")
    expect(page).to have_text(@paper.authors[0].name)
  end

  it "shows the authors if there are some" do
    @authorsPaper = FactoryBot.create :paper_with_multiple_authors
    visit paper_path(@authorsPaper)
    expect(@authorsPaper.authors.count).to be > 1
    expect(page).to have_text("Authors:")
    @authorsPaper.authors.each do |author|
      expect(page).to have_text(author.name)
    end
  end
end

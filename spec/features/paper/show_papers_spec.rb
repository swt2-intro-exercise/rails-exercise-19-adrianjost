require 'rails_helper'

describe "show papers page", type: :feature do
  before do
    papers = FactoryBot.create_list(:paper, 2)
    @paper1 = papers[0]
    @paper2 = papers[1]
    @paper2.update(year: @paper2.year - 1, title: "Some other book the author wrote")
  end

  it "should render withour error" do
    visit paper_path(@paper1)
  end

  it "should display title" do
    visit paper_path(@paper1)
    expect(page).to have_text(@paper1.title)
  end

  it "doesn't shows the author if there are none" do
    @paper1WithoutAuthor = FactoryBot.create :paper_without_author
    visit paper_path(@paper1WithoutAuthor)
    expect(@paper1WithoutAuthor.authors.count).to be 0
    expect(page).not_to have_text("Author")
  end

  it "shows the author if there is one" do
    visit paper_path(@paper1)
    expect(@paper1.authors.count).to be 1
    expect(page).to have_text("Author:")
    expect(page).to have_text(@paper1.authors[0].name)
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

  it "should filter papers with other years out" do
    visit (papers_path + "?year=" + String(@paper2.year))
    expect(page).to_not have_text(@paper1.title)
  end

  it "should show papers with the correct year" do
    visit (papers_path + "?year=" + String(@paper2.year))
    expect(page).to have_text(@paper2.title)
  end
end

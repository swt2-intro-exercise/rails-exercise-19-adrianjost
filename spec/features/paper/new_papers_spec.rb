require 'rails_helper'

describe "New Paper page", type: :feature do
  before do
    authors = FactoryBot.create_list(:author, 2)
    @author1 = authors[0]
    @author2 = authors[1]
    @author1.update(first_name:"Adrian", last_name:"Jost", homepage:"https://adrianjost.dev")
    @author2.update(first_name:"Max", last_name:"Plaga" ,homepage:"https://fotografischunterwegs.de/")
  end

  it "should save the new paper with authors in the database" do
    visit new_paper_path
    page.fill_in 'paper[title]', with: 'some Title'
    page.fill_in 'paper[venue]', with: 'some Venue'
    page.fill_in 'paper[year]', with: 2012
    select @author1.name, :from => "author_ids"
    select @author2.name, :from => "author_ids"
    find('input[type="submit"]').click
    paper = Paper.where(:title => 'some Title', :venue => 'some Venue').first
    expect(paper.title).to(eq("some Title"))
    expect(paper.venue).to(eq("some Venue"))
    expect(paper.year).to(eq(2012))
    expect(paper.authors).to include(@author1, @author2)
 end

  it "allows to select all authors" do
    visit new_paper_path
    expect(page).to have_select("author_ids", with_options:[@author1.name, @author2.name])
  end

  it "allows to select multiple authors" do
    visit new_paper_path
    expect(page.find(:css,'select[multiple="multiple"]')).to_not be_nil
  end
end
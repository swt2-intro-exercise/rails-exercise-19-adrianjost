require 'rails_helper'

describe "edit paper page", type: :feature do
  before do
    @paper = FactoryBot.create :paper
    authors = FactoryBot.create_list(:author, 2)
    @author1 = authors[0]
    @author2 = authors[1]
    @author1.update(first_name:"Adrian", last_name:"Jost", homepage:"https://adrianjost.dev")
    @author2.update(first_name:"Max", last_name:"Plaga" ,homepage:"https://fotografischunterwegs.de/")
  end


  it "allows to select all authors" do
    visit edit_paper_path(@paper)
    expect(page).to have_select("author_ids", with_options:[@author1.name, @author2.name])
  end

  it "allows to select multiple authors" do
    visit edit_paper_path(@paper)
    expect(page.find(:css,'select[multiple="multiple"]')).to_not be_nil
  end

  it "actually updates the authors" do
    visit edit_paper_path(@paper)
    expect(@paper.authors).not_to include(@author1, @author2)

    select @author1.name, :from => "author_ids"
    select @author2.name, :from => "author_ids"
    find('input[type="submit"]').click
    @paper.reload
    expect(@paper.authors).to include(@author1, @author2)
  end

  it "preselect papers authors" do
    visit edit_paper_path(@paper)
    expect(@paper.authors).not_to be_empty
    for author in @paper.authors
      expect(page.find(:css, "option[selected][value=#{author.id}]")).to_not be_nil
    end
  end

  it "can remove selected authors" do
    visit edit_paper_path(@paper)
    expect(@paper.authors).not_to be_empty
    for author in Author.all
      unselect author.name, :from => "author_ids"
    end
    find('input[type="submit"]').click
    @paper.reload
    expect(@paper.authors).to be_empty
  end

end
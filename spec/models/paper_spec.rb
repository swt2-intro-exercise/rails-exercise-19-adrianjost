require 'rails_helper'

RSpec.describe Paper, type: :model do
  it 'should save data' do
    paper = Paper.new(title:'COMPUTING MACHINERY AND INTELLIGENCE', venue:'Mind 49: 433-460', year:1950)
    expect(paper.title).to(eq('COMPUTING MACHINERY AND INTELLIGENCE'))
    expect(paper.venue).to(eq('Mind 49: 433-460'))
    expect(paper.year).to(eq(1950))
  end

  it "should not validate without title" do
    paper = Paper.new(venue:"Some venue", year:1950)
    expect(paper).to_not be_valid
  end

  it "should not validate without venue" do
    paper = Paper.new(title:"Some title", year:1950)
    expect(paper).to_not be_valid
  end

  it "should not validate without year" do
    paper = Paper.new(title:"Some title", venue:"Some venue")
    expect(paper).to_not be_valid
  end

  it "should only accept numeric years" do
    paper = Paper.new(title:"Some title", venue:"Some venue", year:"Some year")
    expect(paper).to_not be_valid
  end

  it "should only accept integer years" do
    paper = Paper.new(title:"Some title", venue:"Some venue", year:19.3)
    expect(paper).to_not be_valid
  end

  it "should have many authors" do
    paper = Paper.new(title:"Some title", venue:"Some venue", year:2019)
    paper.save
    expect(paper.authors).to be_empty
  end
end

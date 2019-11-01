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
end
require 'rails_helper'

describe "Show author page", type: :feature do
 before do
   @alan = FactoryBot.create :author
 end

 it "should render withour error" do
   visit author_path(@alan)
 end

 it "should have some text" do
   visit author_path(@alan)
   expect(page).to have_text(@alan.name)
 end
end
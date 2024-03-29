require 'rails_helper'

describe "New author page", type: :feature do

  it "should render withour error" do
    visit new_author_path
  end

  it "should have text inputs for an author's first name, last name, and homepage" do
    visit new_author_path
    expect(page).to have_field('author[first_name]')
    expect(page).to have_field('author[last_name]')
    expect(page).to have_field('author[homepage]')
  end

  it "should save the new author in the database" do
    visit new_author_path
    page.fill_in 'author[first_name]', with: 'Alan'
    page.fill_in 'author[last_name]', with: 'Turing'
    page.fill_in 'author[homepage]', with: 'http://wikipedia.org/Alan_Turing'
    find('input[type="submit"]').click
    author = Author.where(:first_name => 'Alan', :last_name => 'Turing').first
    expect(author.first_name).to(eq("Alan"))
    expect(author.last_name).to(eq("Turing"))
    expect(author.homepage).to(eq("http://wikipedia.org/Alan_Turing"))
    expect(author.name).to(eq("Alan Turing"))
 end

  it "should show validation errors occured" do
    visit new_author_path
    page.fill_in 'author[first_name]', with: 'Alan'
    page.fill_in 'author[homepage]', with: 'http://wikipedia.org/Alan_Turing'
    find('input[type="submit"]').click
    expect(page).to have_text('error')
  end

  it "should explain errors" do
    visit new_author_path
    page.fill_in 'author[first_name]', with: 'Alan'
    page.fill_in 'author[homepage]', with: 'http://wikipedia.org/Alan_Turing'
    find('input[type="submit"]').click
    expect(page).to have_text('Last name can\'t be blank')
  end

  it "should have back button" do
    visit new_author_path
    expect(page).to have_css("a[href='#{authors_path}']")
  end
end
require 'rails_helper'

RSpec.describe Author, type: :model do
  it 'should show the full author name' do
    author = Author.new(first_name:'Alan', last_name:'Turing', homepage:'turing.com')
    expect(author.first_name).to(eq('Alan'))
    expect(author.last_name).to(eq('Turing'))
    expect(author.homepage).to(eq('turing.com'))
    expect(author.name).to(eq('Alan Turing'))
  end

  it "should not allow authors without last name" do
    author = Author.new(first_name:'Alan', homepage:'turing.com')
    expect(author).to_not be_valid
  end
end
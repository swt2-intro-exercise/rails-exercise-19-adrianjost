class Author < ApplicationRecord
  has_and_belongs_to_many :papers
  validates :last_name, presence: true
  def name
    @out = ""
    @out.concat("", first_name)
    @out.concat(" ", last_name)
  end
end
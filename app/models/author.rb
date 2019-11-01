class Author < ApplicationRecord
  validates :last_name, presence: true
  def name
    @out = ""
    @out.concat("", first_name)
    @out.concat(" ", last_name)
  end
end
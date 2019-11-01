class Paper < ApplicationRecord
  has_and_belongs_to_many :authors
  #query by year
  scope :in_year, ->(year) { where("year = ?", year) }
  #allow update
  attr_accessor :author_ids
  validates :title, presence: true
  validates :venue, presence: true
  validates :year, presence: true, numericality: { only_integer: true }
end

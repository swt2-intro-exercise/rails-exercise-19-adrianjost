FactoryBot.define do
  factory :paper do
    title { "COMPUTING MACHINERY AND INTELLIGENCE" }
    venue { "Mind 49: 433-460" }
    year { 1950 }
    authors {build_list :author, 1}
  end

  factory :paper_without_author, parent: :paper do
    authors {build_list :author, 0}
  end

  factory :paper_with_multiple_authors, parent: :paper do
    authors {build_list :author, 3}
  end
end
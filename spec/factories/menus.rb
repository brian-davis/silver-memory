FactoryBot.define do
  factory :menu do
    name { Faker::Hipster.sentence(word_count: 3) }
  end
end

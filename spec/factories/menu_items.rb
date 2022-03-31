FactoryBot.define do
  factory :menu_item do
    name { Faker::Food.dish }
    price { rand(1.0..100.0) }
  end
end

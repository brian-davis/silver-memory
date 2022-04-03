FactoryBot.define do
  factory :menu_item do
    name { Faker::Food.dish + rand(10000).to_s }
    price { rand(1.0..100.0) }
  end
end

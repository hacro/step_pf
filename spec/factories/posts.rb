FactoryBot.define do
  factory :post do
    user
    spot_type
    caption { Faker::Lorem.characters(number:100)}
    location { Faker::Lorem.characters(number:100)}
    spot_detail { Faker::Lorem.characters(number:100)}
    other_info { Faker::Lorem.characters(number:100)}
  end
  factory :post2 do
    user
    spot_type
    caption { Faker::Lorem.characters(number:100)}
    location { Faker::Lorem.characters(number:100)}
    spot_detail { Faker::Lorem.characters(number:100)}
    other_info { Faker::Lorem.characters(number:100)}
  end
end

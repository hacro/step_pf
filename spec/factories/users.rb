FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 20) }
    sequence(:email) { |n| "testuser#{n}@sample.com" }
    introduction { Faker::Lorem.characters(number:20)}
    password {'password'}
    password_confirmation { 'password' }
  end
end

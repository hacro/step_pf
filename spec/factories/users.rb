FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number: 20) }
    sequence(:email) { |n| "testuser#{n}@sample.com" }
    introduction { Faker::Lorem.characters(number:20)}
    password {'password'}
    password_confirmation { 'password' }

    after(:build) do |user|
      user.profile_image.attach(io: File.open('spec/images/profile_image.jpeg'), filename: 'profile_image.jpeg', content_type: 'application/xlsx')
    end
  end

  factory :user2, class:User do
    name { Faker::Lorem.characters(number:10) }
    sequence(:email) { |n| "testuser#{n}@sample.com" }
    introduction { Faker::Lorem.characters(number:20) }
    password { 'password' }
    password_confirmation { 'password' }
  end
end

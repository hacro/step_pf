FactoryBot.define do
  factory :follow do
    follower_id {FactoryBot.create(:user).id}
    followed_id {FactoryBot.create(:user).id}
  end
end

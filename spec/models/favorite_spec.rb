require 'rails_helper'

RSpec.describe "Favoriteモデルのテスト", type: :model do
  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1の関係になっているか" do
        expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "Postモデルとの関係" do
      it "N:1の関係になっているか" do
        expect(Favorite.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
  describe "バリデーションのテスト" do
    subject {favorite.valid?}
    let!(:other_favorite) {create(:favorite)}
    let(:favorite) {build(:favorite)}
    context "1User 1Post 1いいね" do
      it "あるユーザーが同じPostにいいねできないこと" do
        favorite.user = other_favorite.user
        favorite.post = other_favorite.post
        is_expected.to eq false
      end
    end
  end
end

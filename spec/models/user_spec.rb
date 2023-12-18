require 'rails_helper'

RSpec.describe "Userモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    let(:user) { create(:user) }
    context "nameカラム" do
      it "空欄でないこと" do
        user.name = ''
        expect(user.valid?).to eq false;
      end
      it "20文字以内であること" do
        user.name = Faker::Lorem.characters(number:20)
        expect(user.valid?).to eq true;
      end
      it '21文字以上は弾かれること' do
        user.name = Faker::Lorem.characters(number:21)
        expect(user.valid?).to eq false;
      end
      it '1文字の場合は弾かれること' do
        user.name = Faker::Lorem.characters(number:1)
        expect(user.valid?).to eq false;
      end
    end
    context "introductionカラム" do
      it "空欄でも登録できること" do
        user.introduction = ""
        expect(user.valid?).to eq true;
      end
      it "200文字以内であること" do
        user.introduction = Faker::Lorem.characters(number:200)
        expect(user.valid?).to eq true;
      end
      it "201文字以上は弾かれること" do
        user.introduction = Faker::Lorem.characters(number:201)
        expect(user.valid?).to eq false;
      end
    end
    context "emailカラム" do
      it "空欄でないこと" do
        user.email = ""
        expect(user.valid?).to eq false;
      end
      it "50文字以内であること" do
        user.email = "#{Faker::Lorem.characters(number:39)}@sample.com"
        expect(user.valid?).to eq true;
      end
      it "51文字以上は弾かれること" do
        user.email = "#{Faker::Lorem.characters(number:40)}@sample.com"
        expect(user.valid?).to eq false;
      end
    end
  end
  describe "アソシエーションのテスト" do
    context "postモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:posts).macro).to eq :has_many
      end
    end
    context "favoriteモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
    context "commentモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context "relationshipモデルとの関係" do
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:reverse_of_relationships).macro).to eq :has_many
      end
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:followings).macro).to eq :has_many
      end
      it "1:Nとなっている" do
        expect(User.reflect_on_association(:followers).macro).to eq :has_many
      end
    end
  end
end

require 'rails_helper'

RSpec.describe "Commentモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    let(:comment) { create(:comment) }
    context "commentカラム" do
      it "空欄ではコメントできない" do
        comment.comment = ""
        expect(comment.valid?).to eq false;
      end
      it "200文字以内であること" do
        comment.comment = Faker::Lorem.characters(number:200)
        expect(comment.valid?).to eq true;
      end
      it "201文字以上は弾かれること" do
        comment.comment = Faker::Lorem.characters(number:201)
        expect(comment.valid?).to eq false;
      end
    end
  end
  describe "アソシエーションのテスト" do
    context "Userモデルとの関係" do
      it "N:1の関係になっているか" do
        expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "Postモデルとの関係" do
      it "N:1の関係になっているか" do
        expect(Comment.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end

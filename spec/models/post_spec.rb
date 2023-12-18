require 'rails_helper'

RSpec.describe "Postモデルのテスト", type: :model do
    describe "アソシエーションのテスト" do
        context "Userモデルとの関係" do
            it "N:1の関係となっている" do
                expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
            end
        end
        context "Spot_typeモデルとの関係" do
            it "N:1の関係となっている" do
                expect(Post.reflect_on_association(:spot_type).macro).to eq :belongs_to
            end
        end
        context "favoriteモデルとの関係" do
            it "1:Nの関係となっている" do
                expect(Post.reflect_on_association(:favorites).macro).to eq :has_many
            end
        end
        context "commentモデルとの関係" do
            it "1:Nの関係となっている" do
                expect(Post.reflect_on_association(:comments).macro).to eq :has_many
            end
        end
    end
    describe "バリデーションのテスト" do
        let(:post) { create(:post) }
        context "locationカラム" do
            it "空欄では登録できないこと" do
                post.location = ""
                expect(post.valid?).to eq false;
            end
        end
        context "spot_type_idカラム" do
            it "Spot_typeテーブルに存在するIDは登録できること" do
                post.spot_type_id = 1
                expect(post.valid?).to eq true;
            end
            it "Spot_typeテーブルに存在しないIDは登録できないこと" do
                post.spot_type_id = 3
                expect(post.valid?).to eq false;
            end
        end
        context "captionカラム" do
            it "空欄でも登録できること" do
                post.caption = ""
                expect(post.valid?).to eq true;
            end
            it "200文字以内であること" do
                post.caption = Faker::Lorem.characters(number:200)
                expect(post.valid?).to eq true;
            end
            it "201文字以上は弾かれること" do
                post.caption = Faker::Lorem.characters(number:201)
                expect(post.valid?).to eq false;
            end
        end
        context "spot_deailカラム" do
            it "空欄でも登録できること" do
                post.spot_detail = ""
                expect(post.valid?).to eq true;
            end
            it "200文字以内であること" do
                post.spot_detail = Faker::Lorem.characters(number:200)
                expect(post.valid?).to eq true;
            end
            it "201文字以上は弾かれること" do
                post.spot_detail = Faker::Lorem.characters(number:201)
                expect(post.valid?).to eq false;
            end
        end
        context "other_infoカラム" do
            it "空欄でも登録できること" do
                post.other_info = ""
                expect(post.valid?).to eq true;
            end
            it "200文字以内であること" do
                post.other_info = Faker::Lorem.characters(number:200)
                expect(post.valid?).to eq true;
            end
            it "201文字以上は弾かれること" do
                post.other_info = Faker::Lorem.characters(number:201)
                expect(post.valid?).to eq false;
            end
        end
    end
end

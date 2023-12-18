require 'rails_helper'

RSpec.describe "[ユーザー関連]未ログイン時", type: :request do
    let(:user) { create(:user) }
    context "以下には遷移できず、ログイン画面に遷移する" do
        it "ユーザー詳細画面" do
            get user_path(user)
            expect(response).to have_http_status 302
        end
        it "ユーザー編集画面" do
            get edit_user_path(user)
            expect(response).to have_http_status 302
        end
        it "ユーザー更新アクション" do
            patch user_path(user)
            expect(response).to have_http_status 302
        end
        it "ユーザー退会画面" do
            get unsubscribe_path(user)
            expect(response).to have_http_status 302
        end
        it "ユーザー退会アクション" do
            delete user_path(user)
            expect(response).to have_http_status 302
        end
        it "フォロー/フォロワー一覧画面" do
            get user_follows_path(user)
            expect(response).to have_http_status 302
        end
    end
end

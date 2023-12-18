require 'rails_helper'


RSpec.describe "[ポスト関連]未ログイン時", type: :request do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  context "以下には遷移できず、ログイン画面に遷移する" do
      it "新規投稿画面" do
        get new_post_path
        expect(response).to have_http_status 302
      end

      it "投稿詳細画面" do
        get post_path(post)
        expect(response).to have_http_status 302
      end

      it "投稿編集画面" do
        get edit_post_path(post)
        expect(response).to have_http_status 302
      end

      it "投稿更新アクション" do
        patch post_path(post)
        expect(response).to have_http_status 302
      end

      it "投稿削除アクション" do
        delete post_path(post)
        expect(response).to have_http_status 302
      end
  end
  context "投稿一覧画面" do
    before do
      visit posts_path
    end
    it "みんなの投稿は表示される" do
      expect(page).to have_content('みんなの投稿')
    end
    it "検索タブは表示されない" do
      expect(page).not_to have_content('けんさく')
    end
  end
end

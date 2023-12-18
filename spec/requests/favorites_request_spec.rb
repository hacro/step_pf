require 'rails_helper'

RSpec.describe "[Favorite関連]未ログイン時", type: :request do
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    context "以下には遷移できず、ログイン画面に遷移する" do
        it "いいね一覧" do
            get favorites_path
            expect(response).to have_http_status 302
        end
    end
end

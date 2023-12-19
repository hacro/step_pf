require 'rails_helper'

describe "ポスト" do
    let(:user){ create(:user) }

    before do
        visit new_user_session_path
        fill_in 'user[name]', with: user.name
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
    end
    describe '新規投稿' do
        before do
            visit new_post_path
        end
        context '新規投稿画面の表示テスト' do
            it '「新規投稿」と表示される' do
                expect(page).to have_content('新規投稿')
            end
            it '「休憩スポット」と「遊び場」の選択肢がある' do
                expect(page).to have_content('休憩スポット')
                expect(page).to have_content('遊び場')
            end
            it '「説明（200文字以内）と表示されている」' do
                expect(page).to have_content('説明（200文字以内）')
            end
            it '説明入力フォームが表示される' do
                expect(page).to have_field 'post[caption]'
            end
            it '「この施設があるところ」と表示されている' do
                expect(page).to have_content('この施設があるところ')
            end
            it '住所入力フォームが表示される' do
                expect(page).to have_field 'post[location]'
            end
            # it '検索フォームからキーワードを入力すると、住所がlocationフォームに反映されるか' do
            #     fill_in "input_keyword", with: "東京駅"
            #     find('input[name="search_btn"]').click
            #     expect(page).to have_field 'post[location]',with: "東京都千代田区丸の内１丁目９ 東京駅"
            # end
            it 'Googleマップが表示されている' do
                expect(page).to have_css '#g-map-search'
            end
            it '「施設の詳細（施設の建物名など）」と表示されている' do
                expect(page).to have_content('施設の詳細（施設の建物名など）')
            end
            it '施設の詳細の入力フォームが表示される' do
                expect(page).to have_field 'post[spot_detail]'
            end
            it '「その他（持ち物や注意点）」と表示されている' do
                expect(page).to have_content('その他（持ち物や注意点）')
            end
            it 'その他入力フォームが表示される' do
                expect(page).to have_field 'post[other_info]'
            end
            it '「画像」と表示されている' do
                expect(page).to have_content('画像')
            end
            it '画像投稿フォームが表示されている' do
                expect(page).to have_field 'post[image]'
            end
            it '投稿ボタンが表示されている' do
                expect(page).to have_button '投稿する'
            end
        end
        context '投稿テスト' do
            it '投稿に成功する'do
                fill_in "post[caption]", with: Faker::Lorem.characters(number:10)
                fill_in "post[location]", with: Faker::Lorem.characters(number:10)
                click_button '投稿する'
                expect(current_path).to eq '/posts/' + Post.last.id.to_s
            end
            it 'locationが空欄だと投稿に失敗する' do
                fill_in "post[location]", with: ""
                click_button '投稿する'
                expect(page).to have_content('住所を入力してください')
            end
        end
    end
    describe "投稿編集" do
        let!(:user2) { create(:user) }
        let!(:post) { create(:post, user: user) }
        let!(:post2) { create(:post, user: user2) }

        context '投稿編集画面へのアクセス' do
            it '自分が投稿したポストの編集画面にアクセスできる' do
                visit edit_post_path(post)
                expect(page).to have_content('ポスト編集')
            end
            it '他ユーザーが投稿したポストの編集画面にはアクセスできず、投稿一覧画面に遷移する' do
                visit edit_post_path(post2)
                expect(current_path).to eq posts_path
            end
        end
        context '編集画面の表示確認' do
            before do
                visit edit_post_path(post)
            end
            it '「ポスト編集」と表示されている' do
                expect(page).to have_content('ポスト編集')
            end
            it '「休憩スポット」と「遊び場」の選択肢がある' do
                expect(page).to have_content('休憩スポット')
                expect(page).to have_content('遊び場')
            end
            it '「説明（200文字以内）と表示されている」' do
                expect(page).to have_content('説明（200文字以内）')
            end
            it '説明入力フォームが表示される' do
                expect(page).to have_field 'post[caption]'
            end
            it '「この施設があるところ」と表示されている' do
                expect(page).to have_content('この施設があるところ')
            end
            it '住所入力フォームに住所が入っている' do
                expect(page).to have_field 'post[location]', with: post.location
            end
            it '施設の詳細の入力フォームが表示される' do
                expect(page).to have_field 'post[spot_detail]'
            end
            it '「その他（持ち物や注意点）」と表示されている' do
                expect(page).to have_content('その他（持ち物や注意点）')
            end
            it 'その他入力フォームが表示される' do
                expect(page).to have_field 'post[other_info]'
            end
            it '「画像」と表示されている' do
                expect(page).to have_content('画像')
            end
            it '画像投稿フォームが表示されている' do
                expect(page).to have_field 'post[image]'
            end
            it '内容を変更するボタンが表示されている' do
                expect(page).to have_button '内容を変更する'
            end
        end
        context '編集テスト' do
            before do
                visit edit_post_path(post)
            end
            it '編集が成功する' do
                fill_in 'post[caption]', with: Faker::Lorem.characters(number:10)
                fill_in 'post[location]', with: Faker::Lorem.characters(number:10)
                fill_in 'post[spot_detail]', with: Faker::Lorem.characters(number:200)
                fill_in 'post[other_info]', with: Faker::Lorem.characters(number:100)
                click_button '内容を変更する'
                expect(current_path).to eq post_path(post)
            end
            it 'location空白で編集失敗になる' do
                fill_in 'post[caption]', with: Faker::Lorem.characters(number:10)
                fill_in 'post[location]', with: ""
                fill_in 'post[spot_detail]', with: Faker::Lorem.characters(number:200)
                fill_in 'post[other_info]', with: Faker::Lorem.characters(number:100)
                click_button '内容を変更する'
                expect(page).to have_content("住所を入力してください")
            end
        end
    end
    describe 'ポスト詳細画面' do
        let!(:user2) { create(:user) }
        let!(:post) { create(:post, user: user) }
        let!(:post2) { create(:post, user: user2) }

        context '削除＆編集&フォローボタンの表示' do
            it '自分の投稿へアクセス時、投稿編集&投稿削除リンクが存在する' do
                visit post_path(post)
                expect(page).to have_link nil, href: edit_post_path(post)
                expect(page).to have_link nil, href: post_path(post)
            end
            it '自分の投稿へアクセス時、フォローボタンは表示されない' do
                visit post_path(post)
                expect(page).to have_no_link 'フォロー'
            end
            it '他人の投稿へアクセス時、投稿編集＆投稿削除リンクは存在しない' do
                visit post_path(post2)
                expect(page).to have_no_link nil, href: edit_post_path(post2)
                expect(page).to have_no_link nil, href: post_path(post2)
            end
            it '他人の投稿へアクセス時、フォローボタンは表示される' do
                visit post_path(post2)
                expect(page).to have_link 'フォロー'
            end
        end
        context 'ポスト詳細画面の表示確認' do
            before do
                visit post_path(post)
            end

            it 'ポストと表示されている' do
                expect(page).to have_content('ポスト')
            end
            it '投稿者のプロフィール画像が表示されている' do
                expect(page).to have_css('.user-profile-image')
            end
            it '投稿者のユーザーネームが表示されている' do
                expect(page).to have_content user.name
            end
            # it 'スポットタイプの名称が表示されている' do
            #     expect(page).to have_content(post.spot_type_id.type_name)
            # end
            it 'ラベル「説明」が表示されている' do
                expect(page).to have_content('説明')
            end
            it 'post[caption]の内容が表示されている' do
                expect(page).to have_content(post.caption)
            end
        end
    end
end
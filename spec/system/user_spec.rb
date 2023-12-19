require 'rails_helper'

describe "User認証テスト" do
    describe "新規登録" do
        before do
            visit new_user_registration_path
        end
        context "ユーザー新規登録画面に遷移" do
            it "新規登録に成功する" do
                fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
                fill_in 'user[email]', with: Faker::Internet.email
                fill_in 'user[password]', with: 'password'
                fill_in 'user[password_confirmation]', with: 'password'
                click_button '登録する'
                expect(current_path).to eq posts_path
            end
            it "新規登録に失敗する" do
                fill_in 'user[name]', with: ''
                fill_in 'user[email]', with:''
                fill_in 'user[password]', with:''
                fill_in 'user[password_confirmation]', with:''
                click_button '登録'

                expect(page).to have_content 'Eメールを入力してください'
                expect(page).to have_content 'パスワードを入力してください'
                expect(page).to have_content 'ユーザーネームを入力してください'
                expect(page).to have_content 'ユーザーネームは2文字以上で入力してください'
            end
        end
    end
    describe "ユーザーログイン" do
        let(:user){ create(:user) }
        before do
            visit new_user_session_path
        end
        context 'ユーザーログイン画面に遷移' do
            let(:test_user){ user }
            it 'ログインに成功する' do
                fill_in 'user[name]', with: test_user.name
                fill_in 'user[password]', with: test_user.password
                click_button 'ログイン'
                expect(current_path).to eq(posts_path)
            end
            it 'ログインに失敗する' do
                fill_in 'user[name]', with: ''
                fill_in 'user[password]', with: ''
                click_button 'ログイン'

                expect(current_path).to eq(new_user_session_path)
                expect(page).to have_content 'ユーザーネームまたはパスワードが違います。'
            end
        end
    end
end

describe "ユーザーのテスト" do
    let(:user){ create(:user) }
    let(:user2){ create(:user) }
    before do
        visit new_user_session_path
        fill_in 'user[name]', with: user.name
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
    end
    describe 'マイページ表示のテスト' do
        context "本人アクセス時" do
            before do
                visit mypage_path
            end
            it '新規投稿のリンクボタンが表示される' do
                expect(page).to have_link '新規投稿', href: new_post_path
            end
            it 'プロフィール編集ボタンが表示される' do
                expect(page).to have_link nil, href: edit_user_path(user)
            end
            it '自分のポスト一覧ページのリンクが表示される' do
                expect(page).to have_link nil, href: user_path(user)
                # , href: user_path(user)
            end
            it 'いいね一覧ページのリンクが表示される' do
                expect(page).to have_link nil, href: favorites_path
            end
            it 'フォロー/フォロワーページのリンクが表示される' do
                expect(page).to have_link nil, href: user_follows_path(user)
            end
        end
    end
    describe 'プロフィール編集のテスト' do
        context '他ユーザーの編集画面' do
            it 'アクセスできず投稿一覧画面に遷移' do
                visit edit_user_path(user2)
                expect(current_path).to eq(posts_path)
            end
        end

        context '自分の編集画面' do
            before do
                visit edit_user_path(user)
            end
            it 'アクセスできる' do
                expect(current_path).to eq(edit_user_path(user))
            end
            it '編集できる' do
                click_button '編集する'
                expect(current_path).to eq(mypage_path)
            end
            it '編集に失敗する' do
                fill_in "user[name]", with: ""
                click_button '編集する'
                expect(page).to have_content('ユーザーネームを入力してください')
                expect(page).to have_content('ユーザーネームは2文字以上で入力してください')
            end
            it 'もどるボタンでマイページに戻る' do
                click_link 'もどる', href: mypage_path
                expect(current_path).to eq(mypage_path)
            end
            it '入力フォームに自分の名前が表示される' do
                expect(page).to have_field 'ユーザーネーム', with: user.name
            end
            it '自己紹介フォームに自分の自己紹介文が表示される' do
                expect(page).to have_field 'ひとこと自己紹介', with: user.introduction
            end
        end
    end
    describe '退会関連' do
        it '退会画面にアクセスできる' do
            visit mypage_path
            click_link '退会'
            expect(current_path).to eq(unsubscribe_path(user))
        end
        it '退会できる' do
            visit unsubscribe_path(user)
            click_link'退会する'
            expect(current_path).to eq(root_path)
        end
        it '退会しないボタンのリンク先が投稿一覧' do
            visit unsubscribe_path(user)
            click_link '退会しない'
            expect(current_path).to eq(posts_path)
        end
    end
end

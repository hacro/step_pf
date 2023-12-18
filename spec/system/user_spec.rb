

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
                expect(page).to have_content 'ユーザー名を入力してください'
                expect(page).to have_content 'ユーザー名は2文字以上で入力してください'
            end
        end
    end
end

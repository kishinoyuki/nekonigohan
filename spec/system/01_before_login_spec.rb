require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト' do
    describe 'トップ画面のテスト' do
        before do
            visit root_path
        end
        
        context '表示内容の確認' do
            it 'URLが正しい', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                expect(current_path).to eq '/'
            end
            
            
                
            
            it 'Homeリンクの内容が正しい', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                home_link = find_all('a')[1].text
                expect(page).to have_link home_link, href: root_path
            end
            
            it '新規登録のリンクが表示される: 表示が新規登録である', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                sign_up_link = find_all('a')[4].text
                expect(sign_up_link).to match(/新規登録/)
            end
            
            it '新規登録のリンクの内容が正しい', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                sign_up_link = find_all('a')[4].text
                expect(page).to have_link sign_up_link, href: new_user_registration_path
            end
            
            
            it 'ログインリンクが表示される: 表示がログインである', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                log_in_link = find_all('a')[5].text
                expect(log_in_link).to match(/ログイン/)
            end
            
            it 'ログインリンクの内容が正しい', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                log_in_link = find_all('a')[5].text
                expect(page).to have_link log_in_link, href: new_user_session_path
            end
            
            it 'ゲストログインリンクが表示されている: 表示がゲストログインである', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                guest_login_link = find_all('a')[6].text
                expect(guest_login_link).to match(/ゲストログイン/)
            end
            
            it 'ゲストログインリンクの内容が正しい', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
               guest_login_link = find_all('a')[6].text
               expect(page).to have_link guest_login_link, href: user_guest_sign_in_path
            end
        end
    end
    
    describe 'ヘッダーのテスト: ログインしていない場合' do
        before do
            visit root_path
        end
        
        context '表示内容の確認' do
            it 'Homeリンクが表示されている: 上から１番目のリンクが「Home」である', spec_category: "CRUD機能に対するコントローラの処理と流れ(ログイン状況を意識した応用)" do
               home_link = find_all('a')[1].text
               expect(home_link).to match(/Home/)  
            end
            
            it '新規投稿リンクが表示されている: 上から２番目のリンクが「新規登録」である', spec_category: "CRUD機能に対するコントローラの処理と流れ(ログイン状況を意識した応用)" do
               sign_up_link = find_all('a')[2].text
               expect(sign_up_link).to match(/新規登録/)
            end
            
            it 'ログインリンクが表示されている: 上から３番目のリンクが「ログイン」である', spec_category: "CRUD機能に対するコントローラの処理と流れ(ログイン状況を意識した応用)" do
               log_in_link = find_all('a')[3].text
               expect(log_in_link).to match(/ログイン/)
            end
        end
        
        context 'リンクの内容を確認' do
            subject { current_path }
            
            it 'Homeを押すと、トップ画面に遷移する', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                home_link = find_all('a')[1].text
                home_link = home_link.delete(' ')
                home_link.gsub!(/\n/, '')
                click_link home_link
                is_expected.to eq '/'
            end
            
            it '新規登録を押すと、新規登録画面に遷移する', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                sign_up_link = find_all('a')[2].text
                sign_up_link = sign_up_link.delete(' ')
                sign_up_link = sign_up_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
                click_link sign_up_link
                is_expected.to eq 'users/sign_up'
            end
            
            it 'ログインを押すと、ログイン画面に遷移する', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                log_in_link = find_all('a')[3].text
                log_in_link = log_in_link.delete(' ')
                log_in_link = log_in_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
                click_link log_in_link
                is_expected.to eq 'users/sign_in'
            end
        end
    end
    
    describe 'ユーザー新規登録のテスト' do
        before do
            visit new_user_registration_path
        end
        
        context '表示内容の確認' do
            it 'URLが正しい', spec_category: "deviseの基本的な導入・認証設定" do
                expect(current_path).to eq '/users/sign_up'
            end
            
            it '新規登録と表示される', spec_category: "deviseの基本的な導入・認証設定" do
                expect(page).to have_content '新規登録'
            end
            
            it 'nameフォームが表示される', spec_category: "deviseの基本的な導入・認証設定" do
                expect(page).to have_field 'user[name]'
            end
            
            it 'emailフォームが表示される', spec_category: "deviseの基本的な導入・認証設定" do
                expect(page).to have_field 'user[email]'
            end
            
            it 'passwordフォームが表示される', spec_category: "deviseの基本的な導入・認証設定" do
                expect(page).to have_field 'user[password]'
            end
            
            it 'password_confirmationフォームが表示される', spec_category: "deviseの基本的な導入・認証設定" do
                expect(page).to have_field 'user[password_confirmation]'
            end
            
            it '新規登録ボタンが表示される', spec_category: "deviseの基本的な導入・認証設定" do
                expect(page).to have_button '新規登録'
            end
        end
        
        context '新規投稿成功のテスト' do
            before do
                fill_in 'user[name]', with: Faker::Lorem.characters(number: 5)
                fill_in 'user[email]', with: Faker::Internet.email
                fill_in 'user[password]', with: 'password'
                fill_in 'user[password_confirmation]', with: 'password'
            end
            
            it '正しく新規登録される', spec_category: "CRUD機能に対するコントローラの処理と流れ(ログイン状況を意識した応用)" do
                expect { click_button '新規登録' }.to change(User.all, :count).by(1)
            end
            
            it '新規投稿後のリダイレクト先が、新規登録できたユーザーのマイページになっている', spec_category: "CRUD機能に対するコントローラの処理と流れ(ログイン状況を意識した応用)" do
                click_button '新規登録'
                expect(current_path).to eq '/mypage'
            end
        end
    end
    
    describe 'ユーザーログイン' do
        let(:user) { create(:user) }
        
        before do
            visit new_user_session_path
        end
        
        context '表示内容の確認' do
            it 'URLが正しい', spec_category: "deviseの基本的な導入・認証設定" do
                expect(current_path).to eq '/users/sign_in'
            end
            
            it 'ログインと表示される', spec_category: "deviseの基本的な導入・認証設定" do
                expect(page).to have_content 'ログイン'
            end
            
            it 'emailフォームが表示される', spec_category: "deviseの基本的な導入・認証設定" do
                expect(page).to have_field 'user[email]'
            end
            
            it 'passwordフォームが表示される', spec_category: "deviseの基本的な導入・認証設定" do
                expect(page).to have_field 'user[password]'
            end
            
            it 'ログインボタンが表示される', spec_category: "deviseの基本的な導入・認証設定" do
                expect(page).to have_button 'ログイン'
            end
            
            it 'nameフォームは表示されない', spec_category: "deviseの基本的な導入・認証設定" do
                expect(page).not_to have_field 'user[name]'
            end
        end
        
        context 'ログイン成功のテスト' do
            before do
                fill_in 'user[email]', with: user.email
                fill_in 'user[password]', with: user.password
                click_button 'ログイン'
            end
            
            it 'ログイン後のリダイレクト先が、ログインしたユーザーのマイページになっている', spec_category: "CRUD機能に対するコントローラの処理と流れ(ログイン状況を意識した応用)" do
                expect(current_path).to eq '/mypage'
            end
        end
        
        context 'ログイン失敗のテスト' do
            before do
                fill_in 'user[email]', with: ''
                fill_in 'user[password]', with: ''
                click_button 'ログイン'
            end
            
            it 'ログインに失敗した場合、ログイン画面にリダイレクトされる', spec_category: "CRUD機能に対するコントローラの処理と流れ(ログイン状況を意識した応用)" do
                expect(current_path).to eq '/users/sign_in'    
            end
        end
    end
    
    describe 'ヘッダーのテスト: ログインしている場合' do
        let(:user) { create(:user) }
        
        before do
            visit new_user_session_path
             fill_in 'user[email]', with: user.email
             fill_in 'user[password]', with: user.password
             click_button 'ログイン'
        end
        
        context 'ヘッダーの表示確認' do
            it 'Homeリンクが表示される: 上から1番目のリンクが「Home」である', spec_category: "ログイン状況に合わせた画面表示や機能制限のロジック設定" do
                home_link = find_all('a')[1].text
                expect(home_link).to match(/Home/)
            end
            
            it 'マイページリンクが表示される: 上から２番目のリンクが「マイページ」である', spec_category: "ログイン状況に合わせた画面表示や機能制限のロジック設定" do
                mypage_link = find_all('a')[2].text
                expect(mypage_link).to match(/マイページ/)
            end
            
            it '新規投稿リンクが表示されている: 上から３番目のリンクが「新規投稿」である', spec_category: "ログイン状況に合わせた画面表示や機能制限のロジック設定" do
                new_post_link = find_all('a')[3].text
                expect(new_post_link).to match(/新規投稿/)
            end
            
            it '投稿一覧リンクが表示されている: 上から４番目のリンクが「投稿一覧」である', spec_category: "ログイン状況に合わせた画面表示や機能制限のロジック設定" do
                posts_index_link = find_all('a')[4].text
                expect(posts_index_link).to match(/投稿一覧/)
            end
            
            it '商品一覧リンクが表示されている: 上から５番目のリンクが「商品一覧」である', spec_category: "ログイン状況に合わせた画面表示や機能制限のロジック設定" do
                items_index_link = find_all('a')[5].text
                expect(items_index_link).to match(/商品一覧/)
            end
            
            it 'ユーザー一覧リンクが表示されている: 上から６番目のリンクが「ユーザー一覧」である', spec_category: "ログイン状況に合わせた画面表示や機能制限のロジック設定" do
                users_index_link = find_all('a')[6].text
                expect(users_index_link).to match(/ユーザー一覧/)
            end
            
            it 'ログアウトリンクが表示されている: 上から７番目のリンクが「ログアウト」である', spec_category: "ログイン状況に合わせた画面表示や機能制限のロジック設定" do
                log_out_link = find_all('a')[7].text
                expect(log_out_link).to match(/ログアウト/)
            end
        end
    end
    
    describe 'ユーザーログアウトのテスト' do
        let(:user) { create(:user) }
        
        before do
            visit new_user_session_path
            fill_in 'user[email]', with: user.email
            fill_in 'user[password]', with: user.password
            click_button 'ログイン'
            log_out_link = find_all('a')[7].text
            log_out_link = log_out_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
            click_link log_out_link
        end
        
        context 'ログアウト機能のテスト' do
            it '正しくログアウトできている: ログアウトのリダイレクト先においてログイン画面へのリンクが表示されている', spec_category: "CRUD機能に対するコントローラの処理と流れ(ログイン状況を意識した応用)" do
                expect(page).to have_link 'ログイン', href: '/users/sign_in'
            end
            
            it 'ログアウト後のリダイレクト先がトップページである', spec_category: "CRUD機能に対するコントローラの処理と流れ(ログイン状況を意識した応用)" do
                expect(current_path).to eq '/'
            end
        end
    end
end
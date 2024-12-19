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
    
    
end
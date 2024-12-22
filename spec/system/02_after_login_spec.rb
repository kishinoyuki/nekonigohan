require 'rails_helper'

describe '[STEP2] ユーザーログイン後のテスト' do
    let!(:user) { create(:user) }
    let!(:other_user) { create(:user) }
    let!(:donation_destination) { create(:donation_destination, user: user) }
    let!(:item) { create(:item, user: user, donation_destination: donation_destination) }
    let!(:post) { create(:post, user: user, item: item) }
    let!(:other_donation_destination) { create(:donation_destination, user: other_user) }
    let!(:other_item) { create(:item, user: other_user, donation_destination: other_donation_destination) }
    let!(:other_post) { create(:post, user: other_user, item: other_item) }
    
    before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
    end
    
    describe 'ヘッダーのテスト: ログインしている場合' do
        context 'リンクの内容を確認: ログアウトは「ユーザーログアウトのテスト」でテスト済' do
            subject {current_path}
            
            it 'Homeを押すと、トップ画面へ遷移する', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                home_link = find_all('a')[1].text
                home_link = home_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
                click_link home_link
                is_expected.to eq '/'
            end
            
            it 'マイページを押すと、マイページへ遷移する', spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                mypage_link = find_all('a')[2].text
                mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
                click_link mypage_link
                is_expected.to eq '/mypage'
            end
            
            it '新規投稿を押すと、新規投稿画面へ遷移する',spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                new_post_link = find_all('a')[3].text
                new_post_link = new_post_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
                click_link new_post_link
                is_expected.to eq '/posts/new'
            end
            
            it '投稿一覧を押すと、投稿一覧画面へ遷移する',spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                posts_index_link = find_all('a')[4].text
                posts_index_link = posts_index_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
                click_link posts_index_link
                is_expected.to eq '/posts'
            end
            
            it '商品一覧を押すと商品一覧画面へ遷移する',spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                items_index_link = find_all('a')[5].text
                items_index_link = items_index_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
                click_link items_index_link
                is_expected.to eq '/items'
            end
            
            it 'ユーザー一覧を押すとユーザー一覧へ遷移する',spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                users_index_link = find_all('a')[6].text
                users_index_link = users_index_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
                click_link users_index_link
                is_expected.to eq '/users'
            end
        end
    end
    
end
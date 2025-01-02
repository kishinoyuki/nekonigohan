require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
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
            
            it 'ユーザ一覧を押すとユーザ一覧へ遷移する',spec_category: "ルーティング・URL設定の理解(ログイン状況に合わせた応用)" do
                users_index_link = find_all('a')[6].text
                users_index_link = users_index_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
                click_link users_index_link
                is_expected.to eq '/users'
            end
        end
    end
    
    describe 'マイページのテスト' do
        before do
            visit mypage_path
        end
        
        context '表示内容の確認' do
            it '「マイページ」と表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content 'マイページ'
            end
            
            it 'URLが正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(current_path).to eq '/mypage'
            end
            
            it '投稿のタイトルが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content post.title
            end
            
            it '投稿の本文が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content post.body
            end
            
            it '投稿の評価が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content post.star
            end
            
            it '投稿のタグが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content post.tag
            end
            
            it '投稿の商品名が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.name
            end 
            
            it '投稿の商品ジャンルが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.genre.name
            end
            
            it '投稿の商品価格が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.price
            end
            
            it '投稿の寄付先が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content donation_destination.name
            end
            
            it '投稿の寄付先都道府県が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content donation_destination.location
            end
            
            it '投稿の編集ボタンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_button '編集'
            end
            
            it '投稿の編集ボタンのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link '編集', href: edit_post_path(post)
            end
            
            it '投稿の削除ボタンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_button '削除'
            end
            
            it '投稿の削除ボタンのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link '削除', href: post_path(post)
            end
        end
        
        context 'サイドバーの確認' do
            it '自分の名前が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content user.name
            end
            
            it 'ユーザ編集ボタンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_button 'ユーザ編集'
            end
            
            it 'ユーザ編集ボタンのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link 'ユーザ編集', href: edit_user_path(user)
            end
            
            it '退会ボタンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_button '退会'
            end
            
            it '退会ボタンのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link '退会', href: users_confirm_path(user)
            end
        end
    end
    
    describe '新規投稿のテスト' do
       before do
           visit new_post_path
       end 
       
       context '表示内容の確認' do
           it '「新規投稿」と表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(page).to have_content '新規投稿'
           end
           
           it 'URLが正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(current_path).to eq '/posts/new'
           end
           
           it 'タイトルフォームが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(page).to have_field 'post[title]'
           end
           
           it 'タイトルフォームに値が入っていない', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(find_field('post[title]').value).to be_blank
           end
           
           it '本文のフォームが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
              expect(page).to have_field 'post[body]' 
           end
           
           it '本文のフォームに値が入っていない', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
              expect(find_field('post[body]').value).to be_blank 
           end
           
           it '評価フォームが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
              expect(page).to have_field 'post[star]'           
           end
           
           it '評価フォームに値が入っていない', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(find_field('post[star]').value).to be_black
           end
           
           it 'タグのフォームが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(page).to have_field 'post[tag]'
           end
           
           it 'タグのフォームに値が入っていない', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(find_field('post[tag]').value).to be_black
           end
           
           it '商品名のフォームが表示される' , spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(page).to have_field 'item[name]'
           end
           
           it '商品名のフォームに値が入っていない', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
              expect(find_field('item[name]').value).to be_blank 
           end
           
           it '商品ジャンルのフォームが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(page).to have_select('item_genre_id')
           end
           
           it '商品価格のフォームが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
              expect(page).to have_field 'item[price]' 
           end
           
           it '商品価格のフォームに値が入っていない', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(find_field('item[price]').value).to be_blank
           end
           
           it '寄付先のフォームが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(page).to have_field 'donation_destination[name]'       
           end
           
           it '寄付先のフォームに値が入っていない', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
              expect(find_field('donation_destination[name]').value).to be_blank 
           end
           
           it '寄付先都道府県のフォームが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
              expect(page).to have_select('donation_destination_location')
           end
           
           it '投稿ボタンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
              expect(page).to have_button '投稿'  
           end
       end
       
       context '投稿成功のテスト' do
           before do
               post = create(:post)
               
               fill_in 'post[title]', with: post.title
               fill_in 'post[body]', with: post.body
               fill_in 'post[star]', with: post.star
               fill_in 'post[tag]', with: post.tag
               
               item = create(:item)
               
               fill_in 'item[name]', with: item.name
               fill_in 'item[price]', with: item.price
               
               genre = create(:genre)
               
               item.update(genre: genre)
               
               donation_destination = create(:donation_destination)
               
               fill_in 'donation_destination[name]', with: donation_destination.name
               fill_in 'donation_destination[location]', with: donation_destination.location
           end
           
           it '自分の新しい投稿が正しく保存されている', spec_category: "CRUD機能に対するコントローラの処理と流れ(ログイン状況を意識した応用)" do
               expect { click_button '投稿' }.to change(user.posts, :count).by(1)
           end
           
           it 'リダイレクト先が、保存できた投稿の詳細画面になっている', spec_category: "CRUD機能に対するコントローラの処理と流れ(ログイン状況を意識した応用)" do
              expect(current_path).to eq '/posts/' + Post.last.id.to_s 
           end
       end
    end
    
    describe '投稿一覧画面のテスト' do
        before do
            visit posts_path
        end
        
        context '表示内容の確認' do
            it '「投稿一覧」と表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content '投稿一覧'
            end
            
            it 'URLが正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(current_path).to eq '/posts'
            end
            
            it '自分と他人の画像のリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link '', href: mypage_path
                expect(page).to have_link '', href: user_path(other_post.user)
            end
            
            it '自分と他人の名前のリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link "#{user.name}", href: mypage_path
                expect(page).to have_link "#{other_user.name}", href: user_path(other_post.user)
            end
            
            it '自分の投稿と他人の投稿のタイトルが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content post.title
                expect(page).to have_content other_post.title
            end
            
            it '自分の投稿と他人の投稿の本文が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content post.body
                expect(page).to have_content other_post.body
            end
            
            it '自分の投稿と他人の投稿の評価が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content post.star
                expect(page).to have_content other_post.star
            end
            
            it '自分の投稿と他人の投稿のタグが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content post.tag
                expect(page).to have_content other_post.tag
            end
            
            it '自分の投稿と他人の投稿の商品名が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.name
                expect(page).to have_content other_item.name
            end
            
            it '自分の投稿と他人の投稿の商品ジャンルが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.genre.name
                expect(page).to have_content other_item.genre.name
            end
            
            it '自分の投稿と他人の投稿の商品価格が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.price
                expect(page).to have_content other_item.price
            end
            
            it '自分の投稿と他人の投稿の寄付先が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content donation_destination.name
                expect(page).to have_content other_donation_destination.name
            end
            
            it '自分の投稿と他人の投稿の寄付先都道府県が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content donation_destination.location
                expect(page).to have_content other_donation_destination.location
            end
            
            it '自分の投稿と他人の投稿に詳細ボタンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_button '詳細'
            end
            
            it '詳細ボタンのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link '詳細', href: post_path(post)
                expect(page).to have_link '詳細', href: post_path(other_post)
            end
            
            it '自分の投稿に編集ボタンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_button '編集'
            end
            
            it '投稿の編集ボタンのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link '編集', href: edit_post_path(post)
            end
            
            it '自分の投稿に削除ボタンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_button '削除'
            end
            
            it '投稿の削除ボタンのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link '削除', href: post_path(post)
            end
        end
    end
    
    describe '商品一覧画面のテスト' do
        before do
            visit items_path
        end
        
        context '表示内容の確認' do
            it '「商品一覧」と表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content '商品一覧'    
            end
            
            it 'URLが正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(current_path).to eq '/items'
            end
            
            it '商品名が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.name
                expect(page).to have_content other_item.name
            end
            
            it '商品名のリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link "#{item.name}", href: item_path(item)
                expect(page).to have_link "#{other_item.name}", href: item_path(other_item)
            end
            
            it '商品ジャンルが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.genre.name
                expect(page).to have_content other_item.genre.name
            end
            
            it '商品価格が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.price
                expect(page).to have_content other_item.price
            end
            
            it '寄付先が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content donation_destination.name
                expect(page).to have_content other_donation_destinaton.name
            end
            
            it '寄付先都道府県が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content donation_destination.location 
                expect(page).to have_content other_donation_destination.location
            end
        end
    end
    
    describe 'ユーザ一覧のテスト' do
        before do
            visit users_path
        end
        
        context '表示内容の確認' do
            it '「ユーザ一覧」と表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content 'ユーザ一覧'
            end
            
            it 'URLが正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(current_path).to eq '/users'
            end
            
            it '自分と他人のユーザ名が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content user.name
                expect(page).to have_content other_user.name
            end
            
            it '「マイページ」が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_css('a', text: 'マイページ', count: 2)
            end
            
            it 'マイページのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                second_mypage_link = all('a', text: 'マイページ')[1]['href']
                expect(second_mypage_link).to eq '/mypage'
            end
            
            it '「詳細」が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content '詳細'
            end
            
            it '詳細のリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link '詳細', href: user_path(other_user)    
            end
            
            it '自分のユーザ編集ボタンが表示されている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_button 'ユーザ編集'
            end
            
            it 'ユーザ編集ボタンのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link 'ユーザ編集', href: edit_user_path(user)
            end
            
            it '自分の退会ボタンが表示されている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_button '退会'
            end
            
            it '退会ボタンのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link '退会', href: users_confirm_path(user)
            end
        end
    end
    
    describe '自分の投稿詳細画面のテスト' do
        before do
            visit post_path(post)
        end
        
        context '表示内容の確認' do
            it 'URLが正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(current_path).to eq '/posts/' + post.id.to_s
            end
            
            it '「投稿詳細」が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content '投稿詳細'    
            end
            
            it 'ユーザ画像・名前のリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link post.user.name, href: mypage_path
            end
            
            it '投稿のタイトルが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content post.title
            end
            
            it '投稿の本文が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content post.body    
            end
            
            it '投稿の評価が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content post.star    
            end
            
            it '投稿のタグがあ表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content post.tag    
            end
            
            it '商品名が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.name    
            end
            
            it '商品ジャンルが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.genre.name
            end
            
            it '商品価格が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.price    
            end
            
            it '寄付先が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content donation_destination.name
            end
            
            it '寄付先都道府県が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content donation_destination.location
            end
            
            it '投稿の編集ボタンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_button '編集'
            end
            
            it '編集ボタンのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link '編集', href: edit_post_path(post)    
            end
            
            it '投稿の削除ボタンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_button '削除'    
            end
            
            it '削除ボタンのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link '削除', href: post_path(post)
            end
        end
    end
    
    describe '他人の投稿詳細画面のテスト' do
        before do
            visit post_path(other_post)
        end
        
        context '表示内容の確認' do
            it 'URLが正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(current_path).to eq '/posts/' + other_post.id.to_s
            end
            
            it '「投稿詳細」と表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content '投稿詳細'    
            end
            
            it 'ユーザ画像・名前のリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link other_post.user.name, href: user_path(other_user)    
            end
            
            it '投稿のタイトルが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_post.title    
            end
            
            it '投稿の本文が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_post.body    
            end
            
            it '投稿の評価が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_post.star    
            end
            
            it '投稿のタグが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_post.tag
            end
            
            it '商品名が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_item.name
            end
            
            it '商品ジャンルが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_item.genre.name    
            end
            
            it '商品価格が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_item.price    
            end
            
            it '寄付先が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_donation_destination.name  
            end
            
            it '寄付先都道府県が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_donation_destination.location    
            end
        end
    end
    
    describe '他人のユーザー詳細画面のテスト' do
        before do
            visit user_path(other_user)
        end
        
        context '表示内容の確認' do
            it 'URLが正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(current_path).to eq '/users/' + other_user.id.to_s    
            end
            
            it '「プロフィール」と表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content 'プロフィール'    
            end
            
            it '投稿のタイトルが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_post.title    
            end
            
            it '投稿の本文が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_post.body    
            end
            
            it '投稿の評価が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_post.star    
            end
            
            it '投稿のタグが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_post.tag    
            end
            
            it '商品名が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_item.name    
            end
            
            it '商品ジャンルが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(page).to have_content other_item.genre.name    
            end
            
            it '商品価格が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(page).to have_content other_item.price    
            end
            
            it '寄付先が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(page).to have_content other_donation_destination.name   
            end
            
            it '寄付先都道府県が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(page).to have_content other_donation_destination.location    
            end
            
            it '詳細ボタンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(page).to have_button '詳細'    
            end
            
            it '詳細ボタンのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(page).to have_link '詳細', href: post_path(other_post)    
            end
        end
        
        context 'サイドバーの確認' do
            it 'ユーザの名前が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(page).to have_content other_user.name    
            end
        end
    end
    
    describe '自分の投稿した商品の詳細画面のテスト' do
        before do
            visit item_path(item)
        end
        
        context '表示内容の確認' do
            it 'URLが正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(current_path).to eq '/items/' + item.id.to_s
            end
            
            it '「該当の商品名」の投稿一覧と表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content "#{item.name}"    
            end
            
            it '投稿のタイトルが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.post.title     
            end
            
            it '投稿の本文が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.post.body    
            end
            
            it '投稿の評価が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.post.star    
            end
            
            it '投稿のタグが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.post.tag    
            end
            
            it '商品名が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.name    
            end
            
            it '商品ジャンルが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.genre.name    
            end
            
            it '商品価格が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.price    
            end
            
            it '寄付先が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.donation_destination.name    
            end
            
            it '寄付先都道府県が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content item.donation_destination.location
            end
            
            it '編集ボタンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_button '編集'    
            end
            
            it '編集ボタンのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link '編集', href: edit_post_path(item.post)    
            end
            
            it '削除ボタンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_button '削除'
            end
            
            it '削除ボタンのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link '削除', href: post_path(item.post)
            end
        end
    end
    
    describe '他人の投稿した商品詳細画面のテスト' do
        before do
            visit item_path(other_item)
        end
        
        context '表示内容の確認' do
            it 'URLが正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(current_path).to eq '/items/' + other_item.id.to_s
            end
            
            it '「該当の商品名」の投稿一覧と表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content "#{other_item.name}"    
            end
            
            it '投稿のタイトルが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_item.post.name
            end
            
            it '投稿の本文が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_item.post.body
            end
            
            it '投稿の評価が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(page).to have_content other_item.post.star    
            end
            
            it '投稿のタグが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_item.post.tag
            end
            
            it '商品名が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_item.name    
            end
            
            it '商品ジャンルが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_item.genre.name    
            end
            
            it '商品価格が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_item.price
            end
            
            it '寄付先が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_item.donation_destination.name
            end
            
            it '寄付先都道府県が表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_content other_item.donation_destination.location    
            end
            
            it '詳細ボタンが表示される', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_button '詳細'    
            end
            
            it '詳細ボタンのリンク先が正しい', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(page).to have_link '詳細', href: post_path(other_item.post)
            end
        end
    end
    
    
    
    
    
    
    
end
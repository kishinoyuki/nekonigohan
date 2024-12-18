require 'rails_helper'

Rspec.describe Post, 'Postモデルに関するテスト', type: :model do

    describe '空白のバリデーションチェック' do
        it 'titleが空白の場合にエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージ表示" do
            post = FactoryBot.build(:post, title: '')
            expect(post).to be_invalid
            expect(post.errors.messages[:title]).to_include("can't be blank")
            expect(page).to have_content 'タイトルを入力してください'
        end
        
        it 'bodyが空白の場合にエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージ表示" do
            post = FactoryBot.build(:post, body: '')
            expect(post).to be_invalid
            expect(post.errors.messages[:body]).to_include("can't be blank")
            expect(page).to have_content '本文を入力してください'
        end
        
        it 'starが空白の場合にエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージ表示" do
            post = FactoryBot.build(:post, star: '')
            expect(post).to be_invalid
            expect(post.errors.messages[:star]).to_include("can't be blank")
            expect(page).to have_content '評価を入力してください'
        end
        
        it 'tagが空白の場合にエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージ表示" do
            post = FactoryBot.build(:post, tag: '')
            expect(post).to be_invalid
            expect(post.errors.messages[:tag]).to_include("can't be blank")
            expect(page).to have_content 'タグを入力してください'  
        end
    end
    
    describe 'アソシエーションのテスト' do
       context 'Userモデルとの関係' do
           it 'N:1となっている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(Post.reflect_on_association(:user).macro).to eq :belongs_to
           end
       end 
       
       context 'Itemモデルとの関係' do
           it 'N:1となっている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(Post.reflect_on_association(:item).macro).to eq :belongs_to
           end
       end
       
       context 'PostCommentモデルとの関係' do
           it '1:Nとなっている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
               expect(Post.reflect_on_association(:post_comments).macro).to eq :has_many
           end
       end
    end
end
    
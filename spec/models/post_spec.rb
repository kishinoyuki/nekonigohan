require 'rails_helper'

RSpec.describe Post, 'Postモデルに関するテスト', type: :model do

    describe '空白のバリデーションチェック' do
        it 'titleが空白の場合にエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージ表示" do
            post = FactoryBot.build(:post, title: '')
            post.valid?
            expect(post.errors.messages[:title]).to include("を入力して下さい。")
        end
        
        it 'bodyが空白の場合にエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージ表示" do
            post = FactoryBot.build(:post, body: '')
            post.valid?
            expect(post.errors.messages[:body]).to include("を入力して下さい。")
        end
        
        it 'starが空白の場合にエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージ表示" do
            post = FactoryBot.build(:post, star: '')
            post.valid?
            expect(post.errors.messages[:star]).to include("を入力して下さい。")
        end
        
        it 'tagが空白の場合にエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージ表示" do
            post = FactoryBot.build(:post, tag: '')
            post.valid?
            expect(post.errors.messages[:tag]).to include("を入力して下さい。")
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
    
require 'rails_helper'

RSpec.describe PostComment, 'PostCommentモデルのテスト', type: :model do
    describe '空白のバリデーションチェック' do
        it 'commentが空白の場合にエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージ表示" do
            post_comment = FactoryBot.build(:post_comment, comment: '')
            post_comment.valid?
            expect(post_comment.errors.messages[:comment]).to include("を入力して下さい。")
        end
    end
    
    describe 'アソシエーションのテスト' do
        context 'Postモデルとの関係' do
            it 'N:1となっている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(PostComment.reflect_on_association(:post).macro).to eq :belongs_to
            end
        end
        
        context 'Userモデルとの関係' do
            it 'N:1となっている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(PostComment.reflect_on_association(:user).macro).to eq :belongs_to
            end
        end
    end
end
require 'rails_helper'

RSpec.describe User, 'Userモデルのテスト', type: :model do
    describe 'バリデーションのテスト' do
        context 'nameカラムのバリデーションチェック' do
            it 'nameが空白の場合にエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージ表示" do
               user = FactoryBot.build(:user, name: '')
               user.valid?
               expect(user.errors.messages[:name]).to include("を入力して下さい。")
            end
            
            it '2文字以上であること: 1文字は×', spec_category: "バリデーションとメッセージ表示" do
                user = FactoryBot.build(:user, name: '')
                user.name = Faker::Lorem.characters(number: 1)
                user.valid?
                expect(user.errors[:name]).to include("は2文字以上で入力して下さい。")
            end
            
            it '２文字以上であること: 2文字は○', spec_category: "バリデーションとメッセージ表示" do
                user = FactoryBot.build(:user, name: '')
                user.name = Faker::Lorem.characters(number: 2)
                expect(user.valid?).to eq true
            end
            
            it '20文字以下であること: 20文字は○', spec_category: "バリデーションとメッセージ表示" do
                user = FactoryBot.build(:user, name: '')
                user.name = Faker::Lorem.characters(number: 20)
                expect(user.valid?).to eq true
            end
            
            it '20文字以下であること: 21文字は×', spec_category: "バリデーションとメッセージ表示" do
                user = FactoryBot.build(:user, name: '')
                user.name = Faker::Lorem.characters(number: 21)
                user.valid?
                expect(user.errors[:name]).to include("は20文字以下で入力して下さい。")
            end
            
            it '一意性があること', spec_category: "バリデーションとメッセージ表示" do
                other_user = FactoryBot.create(:user, name: "ABCDE")
                user = FactoryBot.build(:user, name: "ABCDE")
                user.valid?
                expect(user.errors[:name]).to include("はすでに使用されています。")
            end
        end
        
    end
    
    describe 'アソシエーションのテスト' do
        context 'Postモデルとの関係' do
            it '1:Nになっている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(User.reflect_on_association(:posts).macro).to eq :has_many
            end
        end
        
        context 'PostCommentモデルとの関係' do
            it '1:Nになっている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(User.reflect_on_association(:post_comments).macro).to eq :has_many
            end
        end
    end
end
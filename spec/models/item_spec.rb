require 'rails_helper'

RSpec.describe Item, 'Itemモデルに関するテスト', type: :model do
    
    describe '空白のバリデーションチェック' do
        it 'nameが空白の場合にエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージの表示" do
            item = FactoryBot.build(:item, name: '')
            expect(item.errors.messages[:name]).to include("を入力して下さい。")
            expect(page).to have_content('商品名を入力してください')
        end
        
        it 'priceが空白の場合にエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージの表示" do
            item = FactoryBot.build(:item, price: '')
            expect(item.errors.messages[:price]).to include("を入力して下さい")
            expect(page).to have_content('価格を入力してください')
        end
    end
    
    describe 'アソシエーションのテスト' do
        context 'Genreモデルとの関係' do
            it 'N:1となっている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(Item.reflect_on_association(:genre).macro).to eq :belongs_to
            end
        end
        
        context 'DonationDestinationモデルとの関係' do
            it 'N:1となっている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(Item.reflect_on_association(:donation_destination).macro).to eq :belongs_to
            end
        end
        
        context 'Postモデルとの関係' do
            it '1:Nとなっている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(Item.reflect_on_association(:posts).macro).to eq :has_many
            end
        end
        
    end
end
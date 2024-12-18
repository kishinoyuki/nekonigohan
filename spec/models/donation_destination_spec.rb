require 'rails-helper'

RSpec.describe DonationDestination, 'DonationDestinationモデルのテスト', type: :model do
    describe '空白のバリデーションチェック' do
        it 'nameが空白の場合にエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージ表示" do
            donation_destination = FactoryBot.build(:donation_destination, name: '')
            expect(donation_destination.errors.messages[:name]).to_include("can't be blank")
            expect(page).to have_content '寄付先を入力してください'
        end
        
    end
    
    describe 'アソシエーションのテスト' do
        context 'Itemモデルとの関係' do
            it '1:Nとなっている', spec_category: "基本的なアソシエーション概念と適切な変数設定" do
                expect(DonationDestination.reflect_on_association(:items).macro).to eq :has_many
            end
        end
    end
end
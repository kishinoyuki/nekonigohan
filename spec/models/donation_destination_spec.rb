require 'rails_helper'

RSpec.describe DonationDestination, 'DonationDestinationモデルのテスト', type: :model do
    describe '空白のバリデーションチェック' do
        it 'nameが空白の場合にエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージ表示" do
            donation_destination = FactoryBot.build(:donation_destination, name: '')
            donation_destination.valid?
            expect(donation_destination.errors.messages[:name]).to include("を入力して下さい。")
        end
    end
    
    describe 'locationが正しいenumの値を持っているか' do
     DonationDestination.locations.keys.each_with_index do |key, i|
      it "#{i}に対応する地域が正しく設定されているか" do
       location = DonationDestination.create(location: key)
       expect(location.location).to eq(key)
      end
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
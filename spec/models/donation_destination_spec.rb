require 'rails-helper'

RSpec.describe DonationDestination, 'DonationDestinationモデルのテスト', type: :model do
    describe '空白のバリデーションチェック' do
        it 'nameが空白の場合にエラーメッセージが表示されるか', spec_category: "バリデーションとメッセージ表示" do
            donation_destination = FactoryBot.build(:donation_destination, name: '')
            expect(donation_destination.errors.messages[:name]).to include("入力してください")
        end
    end
    
    describe 'locationが正しいenumの値を持っているか' do
        (0..46).each do |i|
            it "#{i}に対応する地域が正しく設定されているか" do
                location = Location.create(location: i)
                expect(location.send(Location.enum.keys[i])).to be true
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
FactoryBot.define do
    factory :genre do
        name { %w[食品 化粧品 キッチン用品 インテリア 日用雑貨 ペット用品].sample }
    end
end
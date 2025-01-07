FactoryBot.define do
    factory :post do
        title {Faker::Lorem.characters(number: 10)}
        body {Faker::Lorem.characters(number: 30)}
        star {rand(1..5)}
        tag {Faker::Lorem.characters(number: 5)}
        private { false }
        user
        item
    end
end
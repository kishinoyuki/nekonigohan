FactoryBot.define do
    factory :post do
        title {Faker::Lorem.character(number: 10)}
        body {Faker::Lorem.character(number: 30)}
        star {rand(1..5)}
        tag {Faker::Lorem.character(number: 5)}
        private { true }
        user
        item
    end
end
FactoryBot.define do
    factory :donation_destination do
        name { Faker::Lorem.character(number: 10)}
        location { Faker::Number.between(from: 0, to: 46) }
    end
end
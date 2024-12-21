FactoryBot.define do
    factory :donation_destination do
        name { Faker::Lorem.character(number: 10)}
        location {rand(0..46)}
    end
end
FactoryBot.define do
    factory :item do
        name { Faker::Lorem.characters(number: 10)}
        price {rand(300..20000)}
        genre
        donation_destination
    end
end
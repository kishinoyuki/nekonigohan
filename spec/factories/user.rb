FactoryBot.define do
    factory :user do
        name {Faker::Lorem.characters(number:10)}
        introduction {Faker::Lorem.character(number: 20)}
        email {Faker::Internet.email(domain: 'example.com') }
        password {'password'}
        password_confirmation {'password'}
        is_active { true }
    end
end
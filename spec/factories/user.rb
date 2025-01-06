FactoryBot.define do
    factory :user do
        name {Faker::Name.unique.name }
        introduction {Faker::Lorem.characters(number: 20)}
        email {Faker::Internet.unique.email(domain: 'example.com') }
        password {'password'}
        password_confirmation {'password'}
        is_active { true }
    end
end
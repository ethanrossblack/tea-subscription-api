FactoryBot.define do
  factory :customer do
    first_name { Faker::Books::Dune.title }
    last_name { Faker::Creature::Dog.name }
    email { Faker::Internet.email }
    address { Faker::Address.full_address }
  end
end

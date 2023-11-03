FactoryBot.define do
  factory :customer do
    first_name { Faker::Books::Dune.title }
    last_name { Faker::Creature::Dog.name }
    email { "#{first_name.parameterize(separator: ".")}.#{last_name}@example.com".downcase }
    address { Faker::Address.full_address }
  end
end

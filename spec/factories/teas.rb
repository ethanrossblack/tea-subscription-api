FactoryBot.define do
  factory :tea do
    title { Faker::Tea.type.variety }
    description { Faker::Hipster.paragraph }
    temperature { Faker::Number.between(from: 150, to: 200) }
    brew_time { Faker::Number.between(from: 1, to: 14) * 30 }
  end
end

FactoryBot.define do
  factory :tea do
    title { "#{Faker::Tea.unique.variety} Tea" }
    description { Faker::Hipster.paragraph }
    temperature { Faker::Number.between(from: 32, to: 40) * 5}
    brew_time { Faker::Number.between(from: 1, to: 14) * 30 }
  end
end

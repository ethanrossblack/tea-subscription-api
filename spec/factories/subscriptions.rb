FactoryBot.define do
  factory :subscription do
    title { "#{Faker::Subscription.unique.plan} #{Faker::Tea.type} Tea Subscription" }
    price { Faker::Number.between(from: 2, to: 10) * 5 - 0.01 }
    frequency { [0,0,0,0,1].sample }
  end
end

ActiveRecord::Base.connection.reset_pk_sequence!('customers')
ActiveRecord::Base.connection.reset_pk_sequence!('subscriptions')
ActiveRecord::Base.connection.reset_pk_sequence!('customer_subscriptions')
ActiveRecord::Base.connection.reset_pk_sequence!('teas')
ActiveRecord::Base.connection.reset_pk_sequence!('subscription_teas')
Faker::UniqueGenerator.clear

customers = FactoryBot.create_list(:customer, 20)
subscriptions = FactoryBot.create_list(:subscription, 10)
teas = FactoryBot.create_list(:tea, 20)

prng = Random.new

# Add 1 to 5 random teas to each subscription
subscriptions.each do |subscription|
  subscription.teas << teas.sample(prng.rand(1..5))
end

customers.each do |customer|
  customer.subscriptions << subscriptions.sample(prng.rand(2..5))
  customer.customer_subscriptions.sample.update(status: 1) # Cancel one customer's subscription
end

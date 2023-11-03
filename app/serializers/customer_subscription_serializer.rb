class CustomerSubscriptionSerializer
  include JSONAPI::Serializer

  attributes :status, :subscription_title
  belongs_to :customer
  belongs_to :subscription
end

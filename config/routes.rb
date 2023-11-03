Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/customer_subscriptions", to: "customer_subscriptions#create"
      patch "/customer_subscriptions/:id/cancel", to: "customer_subscriptions#cancel"
    end
  end
end

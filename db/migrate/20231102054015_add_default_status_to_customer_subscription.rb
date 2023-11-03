class AddDefaultStatusToCustomerSubscription < ActiveRecord::Migration[7.0]
  def change
    change_column :customer_subscriptions, :status, :integer, default: 0 
  end
end

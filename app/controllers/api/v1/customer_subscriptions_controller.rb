class Api::V1::CustomerSubscriptionsController < ApplicationController
  before_action :set_customer_subscription, only: [:cancel]
  
  def index
    customer = Customer.find(params[:id])
    render json: CustomerSubscriptionSerializer.new(customer.customer_subscriptions)
  end

  def create
    customer_subscription = CustomerSubscription.create(customer_subscription_params)
    render json: CustomerSubscriptionSerializer.new(customer_subscription), status: :created
  end

  def cancel
    if @customer_subscription.update(status: :cancelled)
      render json: CustomerSubscriptionSerializer.new(@customer_subscription)
    end
  end

  private

  def customer_subscription_params
    params.require(:customer_subscription).permit(:customer_id, :subscription_id)
  end

  def set_customer_subscription
    @customer_subscription = CustomerSubscription.find(params[:id])
  end
end

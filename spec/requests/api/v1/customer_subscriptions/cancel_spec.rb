require "rails_helper"

describe "PATCH /api/v1/customer_subscriptions/<id>/cancel" do
  describe "Cancel a customer's subscription" do
    describe "Happy Path" do
      it "Can update a customer_subscription's status to 'cancelled'" do
        # Test Data
        customer = create(:customer)
        subscription = create(:subscription)

        # Add subscription to customer AKA create new customer_subscription
        customer.subscriptions << subscription
        customer_subscription = customer.customer_subscriptions.last

        # Test that the initial customer_subscription status is "active"
        expect(customer_subscription.status).to eq("active")

        # Make patch request to the cancel endpoint
        patch "/api/v1/customer_subscriptions/#{customer_subscription.id}/cancel"

        # Refresh DB After Update
        customer_subscription = customer.customer_subscriptions.last

        # Test that the customer_subscription status is now cancelled
        expect(customer_subscription.status).to eq("cancelled")

        # Test response body
        json = JSON.parse(response.body, symbolize_names: true)
        expect(json).to be_a Hash
        expect(json.keys).to contain_exactly(:data)
        
        data = json[:data]
        expect(data).to be_a Hash
        expect(data.keys).to contain_exactly(:id, :type, :attributes, :relationships)

        expect(data[:id].to_i).to eq(customer_subscription.id)
        expect(data[:type]).to eq("customer_subscription")
        
        expect(data[:attributes]).to be_a Hash
        expect(data[:attributes].keys).to contain_exactly(:status)
        expect(data[:attributes][:status]).to eq("cancelled")
        
        relationships = data[:relationships]
        expect(relationships).to be_a Hash
        expect(relationships.keys).to contain_exactly(:customer, :subscription)

        expect(relationships[:customer]).to be_a Hash
        expect(relationships[:customer].keys).to contain_exactly(:data)
        expect(relationships[:customer][:data]).to be_a Hash
        expect(relationships[:customer][:data].keys).to contain_exactly(:id, :type)
        expect(relationships[:customer][:data][:id].to_i).to eq(customer.id)
        expect(relationships[:customer][:data][:type]).to eq("customer")

        expect(relationships[:subscription]).to be_a Hash
        expect(relationships[:subscription].keys).to contain_exactly(:data)
        expect(relationships[:subscription][:data]).to be_a Hash
        expect(relationships[:subscription][:data].keys).to contain_exactly(:id, :type)
        expect(relationships[:subscription][:data][:id].to_i).to eq(subscription.id)
        expect(relationships[:subscription][:data][:type]).to eq("subscription")
      end
    end
  end
end
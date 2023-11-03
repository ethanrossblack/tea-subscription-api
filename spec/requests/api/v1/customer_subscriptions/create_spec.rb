require "rails_helper"

describe "POST /api/v1/customer_subscriptions" do
  describe "Create new customer subscription" do
    describe "Happy Path" do
      it "can create a new subscription for a customer" do
        # Test Data
        customer = create(:customer)
        subscription = create(:subscription)
        
        params = {
          subscription_id: subscription.id,
          customer_id: customer.id
        }
        headers = {"CONTENT_TYPE": "application/json"}
        
        # Verify that `customer` has no subscriptions
        expect(customer.subscriptions).to be_empty

        # Make post request to the endpoint, including the headers and params
        post "/api/v1/customer_subscriptions", headers: headers, params: JSON.generate(params)

        # Verify that the endpoint returned a successful creation response
        expect(response).to be_successful
        expect(response.status).to eq(201)

        # Verify that the response is formatted correctly
        customer_subscription = CustomerSubscription.last
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
        expect(data[:attributes][:status]).to eq(customer_subscription.status) # Status is "active" by default
        
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

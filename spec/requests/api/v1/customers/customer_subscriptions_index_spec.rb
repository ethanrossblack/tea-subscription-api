describe "GET /api/v1/customers/:id/customer_subscriptions" do
  describe "Get all of a customer's customer_subscriptions" do
    describe "Happy Path" do
      it "can return every subscription of a customer, active and inactive" do
        # Test Data
        customer = create(:customer)
        subscription1 = create(:subscription)
        subscription2 = create(:subscription)

        # Add subscriptions to customer AKA create new customer_subscriptions
        customer_subscription1 = CustomerSubscription.create(customer_id: customer.id, subscription_id: subscription1.id, status: "active")
        customer_subscription2 = CustomerSubscription.create(customer_id: customer.id, subscription_id: subscription2.id, status: "cancelled")
        customer_subscriptions = customer.customer_subscriptions

        # Make the get request for a given customer
        get "/api/v1/customers/#{customer.id}/customer_subscriptions"

        # Verify that the endpoint returned a successful creation response
        expect(response).to be_successful
        expect(response.status).to eq(200)

        json = JSON.parse(response.body, symbolize_names: true)
        expect(json).to be_a Hash
        expect(json.keys).to contain_exactly(:data)

        data = json[:data]
        expect(data).to be_an Array
        expect(data.length).to eq 2
        
        expect(data[0].keys).to contain_exactly(:id, :type, :attributes, :relationships)
        expect(data[0][:id].to_i).to eq(customer_subscription1.id)
        expect(data[0][:type]).to eq("customer_subscription")

        expect(data[0][:attributes]).to be_a Hash
        expect(data[0][:attributes].keys).to contain_exactly(:status, :subscription_title)
        expect(data[0][:attributes][:status]).to eq(customer_subscription1.status)
        expect(data[0][:attributes][:subscription_title]).to eq(subscription1.title)
        
        relationships = data[0][:relationships]
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
        expect(relationships[:subscription][:data][:id].to_i).to eq(subscription1.id)
        expect(relationships[:subscription][:data][:type]).to eq("subscription")
      end
    end
  end
end
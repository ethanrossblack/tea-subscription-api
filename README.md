# Ethan's Tea Subscription Service API

## Install
```
bundle install
```
## Set up database
```
rails db:{create,migrate,seed}
```

# API Endpoints

## Create New Customer Subscription

This endpoint adds a new Subscription to a Customer by creating a row in the `customer_subscriptions` table.

### Request

#### Endpoint

`POST` `/api/v1/customer_subscriptions`

#### Request Body (Required)

Sent as `application/json`


```json
{
    "subscription_id": 1,
    "customer_id": 1
}
```

### Response

#### `201` Created

```
{
    "data": {
        "id": "68",
        "type": "customer_subscription",
        "attributes": {
            "status": "active"
        },
        "relationships": {
            "customer": {
                "data": {
                    "id": "1",
                    "type": "customer"
                }
            },
            "subscription": {
                "data": {
                    "id": "1",
                    "type": "subscription"
                }
            }
        }
    }
}
```
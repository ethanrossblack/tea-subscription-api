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

```json
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

## Cancel A Customer Subscription

This endpoint updates a `customer_subscription` by changing its status to `'cancelled'`.

### Request

#### Endpoint

`PATCH` `/api/v1/customer_subscriptions/:id/cancel`

### Response

#### `200` OK

```json
{
    "data": {
        "id": "68",
        "type": "customer_subscription",
        "attributes": {
            "status": "cancelled"
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


# Ethan's Tea Subscription Service API

This project is a sample Tea Subscription Service API for a mock job technical challenge.

### Running on
- Ruby 3.2.2
- Rails 7.0.8

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

## Get All of a Customer's Subscriptions

This endpoint retrieves all of a customer's customer_subscriptions

### Request

#### Endpoint

`GET` `/api/v1/customers/:id/customer_subscriptions`

### Response

#### `200` OK

```json
{
    "data": [
        {
            "id": "5",
            "type": "customer_subscription",
            "attributes": {
                "status": "active",
                "subscription_title": "Standard Black Tea Subscription"
            },
            "relationships": {
                "customer": {
                    "data": {
                        "id": "2",
                        "type": "customer"
                    }
                },
                "subscription": {
                    "data": {
                        "id": "9",
                        "type": "subscription"
                    }
                }
            }
        },
        {
            "id": "4",
            "type": "customer_subscription",
            "attributes": {
                "status": "cancelled",
                "subscription_title": "Silver Herbal Tea Subscription"
            },
            "relationships": {
                "customer": {
                    "data": {
                        "id": "2",
                        "type": "customer"
                    }
                },
                "subscription": {
                    "data": {
                        "id": "10",
                        "type": "subscription"
                    }
                }
            }
        },
        ...
    ]
}
```


# Product Specification

## 1. Product Vision

Create a trusted digital marketplace and operating layer for farmers.

The product should help a farmer move from:

```text
Know the market
→ Find demand
→ Decide where/how to sell
→ Agree a sale
→ Arrange transport
→ Deliver
→ Verify
→ Get paid
→ Keep a record
```

The product is not merely a price board.

## 2. Target Users

### Farmer

Needs:

- current market information
- price comparison
- buyer discovery
- produce listing
- order visibility
- transport assistance
- payment visibility
- transaction history

### Buyer

Needs:

- discover produce
- publish demand
- communicate requirements
- manage purchases
- coordinate delivery
- track transactions

### Transporter

Needs:

- discover/receive assigned jobs
- pickup information
- delivery information
- trip status
- proof of pickup/delivery
- earnings/history

### Admin / Operations

Needs:

- manage users
- verify participants
- manage market data
- oversee orders
- monitor transactions
- handle disputes
- manage operational exceptions

## 3. Product Principles

### Trust

Users should understand:

- where information came from
- when it was updated
- what is confirmed
- what is estimated
- what is still pending

### Simplicity

A farmer should not need to understand the platform's internal complexity.

### Practical value

The product should help users make and execute decisions, not simply display information.

### Transparency

Prices, quantities, status, and transaction events should be clearly represented.

## 4. MVP

The first release should focus on a narrow set of commodities and locations.

MVP capabilities:

1. Authentication
2. Farmer profile
3. Market price viewing
4. Market comparison
5. Buyer registration
6. Buyer demand/listings
7. Farmer produce listings
8. Offer/order flow
9. Basic transaction lifecycle
10. Notifications
11. Basic transporter workflow
12. Transaction history

Do not attempt every crop, every region, advanced lending, insurance, or complex forecasting in the first release.

## 5. Market Price Model

Each price record should conceptually include:

```text
commodity
grade
market/location
price
unit
currency
timestamp
source
price_type
```

Possible price types:

- indicative
- reported
- buyer offer
- completed transaction

These must not be confused.

A completed transaction price is different from an indicative market price.

## 6. Market Comparison

The product should eventually compare:

```text
Gross sale price
- estimated transport
- applicable selling/logistics costs
= estimated net value
```

This is decision support, not a guarantee.

The UI should clearly distinguish estimates from confirmed amounts.

## 7. Buyer Marketplace

Buyers can publish demand:

```text
Commodity
Quantity
Grade
Target location
Offer price
Required date
Payment terms
Other requirements
```

Farmers can discover relevant demand.

## 8. Produce Listing

A farmer can describe:

```text
Commodity
Available quantity
Grade/quality
Location
Available date
Expected price / negotiable
```

The system should make it easy to update remaining quantity after sales.

## 9. Order

An order records the agreed transaction.

Conceptually:

```text
Buyer
Farmer
Produce
Quantity
Price
Quality
Pickup/delivery
Payment terms
Status
Created time
Updated time
```

## 10. Logistics

Transport should be connected to the order.

A transport job should reference:

```text
Order
Cargo
Pickup
Destination
Transporter
Vehicle
Status
Proof/events
```

## 11. Payments

The MVP should distinguish:

```text
Expected
Pending
Confirmed
Failed
Refunded / Reversed
```

Do not display "Paid" merely because a payment request was initiated.

## 12. Notifications

Important notifications include:

- price alert
- buyer demand matching farmer's produce
- offer received
- offer accepted
- order update
- transporter assigned
- pickup confirmeds
- delivery confirmed
- payment confirmed

Notifications should be actionable and concise.

## 13. Future Capabilities

Potential later capabilities:s

- price trend analysis
- demand forecasting
- harvest planning
- farmer transaction-based financial services
- input financing
- insurance
- warehouse/storage discovery
- quality verification
- digital contracts
- aggregation through cooperatives/AMCOS
- advanced analytics

These are future scope, not automatic MVP requirements.
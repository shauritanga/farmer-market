# User Flows

## 1. Farmer — First Use

```text
Install
→ Register
→ Verify identity/contact as required
→ Select Farmer
→ Add profile
→ Add farm
→ Select crops
→ Home
```

Keep onboarding short. Ask for additional information when it becomes useful.

## 2. Farmer — Check Price

```text
Home
→ Market
→ Select crop
→ Select location/market
→ View current prices
→ Compare markets
→ View timestamp/source
```

The user should understand whether a price is indicative, offered, or transaction-derived.

## 3. Farmer — Decide Where to Sell

```text
Select produce
→ Enter available quantity
→ Select location
→ Compare markets/buyer offers
→ See gross price
→ See estimated costs
→ See estimated net value
→ Choose an opportunity
```

Do not present an estimated net value as a guaranteed sale price.

## 4. Farmer — Sell to Buyer

```text
Buyer opportunity
→ View requirements
→ Review buyer information
→ Submit offer/respond
→ Agree terms
→ Create order
→ Track order
```

## 5. Buyer — Find Produce

```text
Buyer Home
→ Find Produce
→ Search/filter
→ View listing
→ Review farmer/produce information
→ Make offer / proceed according to workflow
→ Order
```

## 6. Buyer — Post Demand

```text
Buyer Home
→ Post Buying Request
→ Commodity
→ Quantity
→ Grade
→ Location
→ Price/terms
→ Publish
→ Receive farmer responses
```

## 7. Transporter — Assigned Trip

```text
Transport Jobs
→ Open assigned job
→ Review cargo
→ Review pickup
→ Accept
→ Arrive
→ Confirm pickup
→ In transit
→ Confirm delivery
→ Complete
```

## 8. Transaction Lifecycle

```text
Created
↓
Accepted
↓
Preparing
↓
Picked Up
↓
In Transit
↓
Delivered
↓
Verified
↓
Paid
↓
Completed
```

Every transition should have a clear actor and timestamp.

## 9. Price Alert

```text
Farmer
→ Set crop
→ Set market/location
→ Set target price
→ Save alert

System
→ receives new/updated price
→ evaluates rule
→ sends notification when condition is met
```

## 10. Offline Price Viewing

```text
Farmer opens Market
→ no network
→ cached prices available
→ show cached price
→ show exact last-updated timestamp
→ allow refresh when network returns
```

Never label cached data as "live".

## 11. Error/Recovery Principle

For every important flow, define:

```text
Loading
Success
Empty
Error
Offline
Retry
```

The user should understand what happened and what they can do next.
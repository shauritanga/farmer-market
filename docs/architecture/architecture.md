# Architecture

## 1. Overview

The platform uses a shared backend and one role-aware Flutter mobile application.

```text
                    Mobile Application
             ┌──────────┼──────────┐
             │          │          │
          Farmer      Buyer    Transporter
             │          │          │
             └──────────┼──────────┘
                        │
                    API Backend
                        │
                 PostgreSQL / Cache
                        │
             ┌──────────┼──────────┐
             │          │          │
          Prices      Orders    Payments
             │          │          │
             └──────────┼──────────┘
                        │
                Admin Web Portal
```

## 2. Mobile Architecture

```text
lib/
├── app/
├── core/
└── features/
```

Each feature follows:

```text
feature/
├── data/
│   ├── datasources/
│   ├── models/
│   ├── mappers/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
└── presentation/
    ├── pages/
    ├── widgets/
    ├── state/
    └── providers/
```

## 3. Dependency Rule

```text
Presentation → Domain ← Data
```

Data implements Domain contracts.

Presentation consumes Domain contracts/use cases.

Domain knows nothing about infrastructure.

## 4. Core

`core/` contains only genuinely cross-feature concerns:

- errors
- networking primitives
- storage abstractions
- theme
- localization
- shared UI primitives
- utilities

Feature-specific components do not belong in `core/`.

## 5. Main Features

### Authentication

Identity, session, role resolution.

### Market Prices

Current prices, historical prices, price freshness, market comparison.

### Farmer Profile

Farmer identity and account information.

### Farms

Farm locations, acreage, crops, expected harvest.

### Produce

Available produce and farmer listings.

### Buyers

Buyer profiles and verification information.

### Listings

Buyer demand and farmer offers.

### Orders

Agreed transactions and lifecycle.

### Logistics

Transport requests, pickup, transit, delivery.

### Payments

Payment status and transaction records.

### Notifications

Price alerts, order updates, delivery updates.

### Transactions

Completed sale history and receipts.

## 6. Data Flow

Typical read:

```text
Page
 ↓
Presentation State
 ↓
Use Case
 ↓
Repository Contract
 ↓
Repository Implementation
 ↓
Data Source
 ↓
API / Cache
```

Typical write:

```text
User Action
 ↓
Presentation State
 ↓
Use Case
 ↓
Repository
 ↓
Remote API
 ↓
Persistence
```

## 7. Offline Strategy

Important read-heavy information should be cacheable.

Example:

```text
Network
 ↓
Latest price
 ↓
Cache
 ↓
UI
```

When offline:

```text
Cache
 ↓
UI
 ↓
"Last updated at..."
```

The timestamp is part of the information, not optional decoration.

## 8. Transaction Lifecycle

The canonical sale lifecycle is:

```text
Created
→ Accepted
→ Preparing
→ Picked Up
→ In Transit
→ Delivered
→ Verified
→ Paid
→ Completed
```

The backend is the source of truth for lifecycle transitions.

The mobile client must not manufacture a successful state locally for a transaction that requires server confirmation.

## 9. Role Security

Roles influence available workflows, but backend authorization is authoritative.

Example permissions:

```text
Farmer
- create own produce listing
- view market prices
- respond to buyer demand
- manage own orders

Buyer
- create buying requests
- discover produce
- make/accept offers as defined by the workflow
- manage own purchases

Transporter
- view assigned jobs
- update assigned transport state
- confirm pickup/delivery

Admin
- operational management
- verification
- dispute handling
- market data administration
```

Exact permissions belong in the backend authorization model.

## 10. Performance

Prefer:

- const widgets
- local state boundaries
- lazy lists
- pagination
- cached read models
- minimal rebuild scopes

Avoid:

- large rebuild trees
- unbounded list rendering
- unnecessary streams
- unnecessary animations
- unnecessary dependencies

## 11. Architecture Decision Rule

When choosing between two valid designs, prefer the one that:

1. has fewer responsibilities per class;
2. has fewer cross-feature dependencies;
3. is easier to test;
4. is easier for a new developer to understand;
5. does not sacrifice runtime performance.

Document significant decisions in `docs/architecture/decisions/`.s
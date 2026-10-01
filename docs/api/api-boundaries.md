# API Boundaries

This document defines conceptual API boundaries. Exact endpoints should be agreed with the backend contract before implementation.

## Authentication

Responsibilities:

- registration
- login
- session
- role resolution
- logout
- credential recovery

## Market Prices

Responsibilities:

- current prices
- historical prices
- market comparison
- price alerts

Important rule:

The API should return freshness metadata and source/type information with prices.

## Produce

Responsibilities:

- farmer listings
- available quantity
- quality/grade
- listing lifecycle

## Buyers

Responsibilities:

- buyer profile
- verification state
- buyer demand

## Offers / Orders

Responsibilities:

- offers
- acceptance
- agreed terms
- order lifecycle
- status history

Critical actions should support idempotency.

## Logistics

Responsibilities:

- transport request
- assignment
- pickup
- transit
- delivery
- proof/events

## Payments

Responsibilities:

- payment initiation
- provider reference
- payment status
- confirmation
- reconciliation

The mobile app must not independently decide that a payment succeeded.

## Notifications

Responsibilities:

- notification creation
- read/unread state
- delivery preferences
- price alerts
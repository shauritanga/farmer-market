# Farmer Market Platform — Agent Constitution

This file is the canonical project-wide instruction for AI coding agents and developers.

## 0. Scope

This is a monorepo with three apps:

```text
apps/
├── mobile/   Flutter — Farmer/Buyer/Transporter (this file's §2–§8 architecture rules apply directly)
├── web/      React + TypeScript — Admin/Operations dashboard
└── backend/  NestJS + Prisma + PostgreSQL — shared API for both clients
```

The mission, UX principles, price/order/payment integrity rules (§1, §4, §9–§13) apply to
**all three apps**. The specific folder layout in §2 describes the Flutter app; `apps/web`
and `apps/backend` follow the same spirit (feature-first, clear layer boundaries, no
dead-end abstractions) documented in their own `CLAUDE.md`. Read `docs/` for the shared
product/architecture/API contract before working in any app.

## 1. Mission

Build a practical agricultural marketplace that helps farmers:

1. understand current market prices;
2. discover genuine buyer demand;
3. compare markets using estimated net value, not price alone;
4. sell produce through a clear digital workflow;
5. arrange transport;
6. track delivery;
7. verify quantity/quality;
8. receive and record payment;
9. maintain a trustworthy transaction history.

The product must feel like a serious agricultural/business product, not an AI-generated dashboard.

## 2. Non-Negotiable Architecture

Use **Clean Architecture + Feature-First**.

Dependency direction:s

```text
Presentation → Domain ← Data
```

Domain must not depend on Flutter UI, HTTP clients, databases, or infrastructure implementations.

Recommended structure:

```text
lib/
├── app/
│   ├── app.dart
│   ├── router/
│   └── bootstrap/
├── core/
│   ├── error/
│   ├── network/
│   ├── storage/
│   ├── theme/
│   ├── localization/
│   ├── utils/
│   └── widgets/
├── features/
│   ├── authentication/
│   ├── market_prices/
│   ├── farmer_profile/
│   ├── farms/
│   ├── crops/
│   ├── produce/
│   ├── buyers/
│   ├── listings/
│   ├── orders/
│   ├── logistics/
│   ├── payments/
│   ├── notifications/
│   └── transactions/
└── main.dart
```

Each feature owns its domain, data, and presentation code.

Do not create a global `screens/`, `models/`, `services/`, `controllers/`, or `repositories/` structure.

## 3. File Size

**No Dart file may exceed 500 lines.**

Target `<300` lines where practical.

If a file approaches 400 lines, consider extracting a meaningful responsibility. Never split files merely to game the line count.

## 4. UI Direction

The UI must be:

- clean
- restrained
- readable
- fast
- trustworthy
- practical
- visually appealing through typography, spacing, hierarchy, and useful imagery

Avoid by default:

- gradients
- glassmorphism
- neon colors
- decorative blobs
- excessive rounded cards
- excessive shadows
- icon overload
- random illustrations
- unnecessary animation
- emoji as interface decoration
- dashboard-style clutter
- AI-looking visual patterns

Do not add a visual element unless it improves comprehension, decision-making, action, or status communication.

Typography and spacing should create hierarchy before decoration does.

## 5. Reusable Components

Create shared components only when there is genuine reuse.

Good examples:

- `AppButton`
- `AppTextField`
- `AppLoading`
- `AppErrorState`
- `AppEmptyState`
- `AppDialog`
- `StatusBadge`

Avoid giant configurable abstractions such as `UniversalCardBuilder`.

Prefer composition over configuration-heavy widgets.

Reusable components must not introduce unnecessary state, listeners, animations, or rebuilds.

## 6. Performance

- Prefer `const`.
- Keep state as local as possible.
- Avoid unnecessary rebuilds.
- Never perform expensive work in `build()`.
- Never perform network calls in `build()`.
- Use lazy lists for large collections.
- Use pagination for large server datasets.
- Dispose controllers/subscriptions correctly.
- Do not add packages without justification.
- Cache read-heavy data where appropriate.
- Design important farmer workflows for unreliable connectivity.

Every important async screen should define loading, success, empty, error, and offline behavior where relevant.

## 7. Domain/Data/Presentation

Domain contains:

- entities
- value objects where useful
- repository contracts
- use cases
- business rules

Data contains:

- DTOs/models
- data sources
- mappers
- repository implementations

Presentation contains:

- pages
- widgets
- state
- presentation-specific models

Never expose API DTOs directly to widgets.

## 8. Use Cases

Use meaningful business actions:

- `GetCurrentMarketPrices`
- `CompareMarkets`
- `CreateProduceListing`
- `AcceptBuyerOffer`
- `CreateOrder`
- `ConfirmPickup`
- `ConfirmDelivery`
- `RecordSale`

Avoid vague use cases such as `ProcessData` or `HandleScreen`.

## 9. Security

Role-based UI is not security.

Backend authorization must independently enforce permissions.

Never trust client-supplied roles.

Never log:

- passwords
- tokens
- PINs
- payment credentials
- unnecessary personal data

Financial/marketplace actions must be protected against duplicate submission. Prefer server-side idempotency for critical operations.

## 10. Product Roles

One mobile application initially supports:

- Farmer
- Buyer
- Transporter

The backend is shared.

Admin/operations should be a separate web application.

Users see only the workflows relevant to their role.

## 11. Price Integrity

A displayed price must have enough context:

- commodity
- grade/quality where applicable
- unit
- market/location
- timestamp
- source or price type where applicable

Cached prices must never be presented as live.

## 12. UX Rules

Every screen must have:

- clear purpose
- clear hierarchy
- obvious primary action
- loading state
- success state
- empty state where applicable
- error state
- offline behavior where relevant

Forms must validate clearly and preserve entered information where practical.

Destructive actions require explicit confirmation.

Do not use browser-style alerts for important interactions.

## 13. Accessibility and Localization

Support:

- readable text
- adequate contrast
- semantic labels
- touch-friendly controls
- screen readers
- predictable navigation
- information not conveyed by color alone

User-facing strings must be localizable.

Initial language may be English, but architecture must support Swahili.

## 14. Testing

Test:

### Domain

- business rules
- calculations
- validation
- use cases

### Data

- DTO parsing
- mapping
- repositories
- API failures
- caching

### Presentation

- loading
- success
- empty
- error
- important interactions

Critical marketplace/payment flows should receive integration/widget coverage.

## 15. Agent Workflow

Before coding:

1. Read this file.
2. Inspect the existing project.
3. Inspect related features.
4. Inspect routing, state management, design system, and API contracts.
5. Identify reusable components.
6. Write a concise implementation plan.

Then implement in this order:

```text
Domain
→ Data
→ Presentation
→ Integration
→ Tests
→ Validation
```

Do not perform unrelated refactors.

Do not silently replace existing architecture.

## 16. Validation

Before declaring a feature complete:

```bash
dart format .
flutter analyze
flutter test
```

Also inspect file sizes.

No file over 500 lines.

Never claim a command passed unless it was actually executed.

## 17. Required Completion Report

Every agent must report:

```text
## Implemented
- ...

## Files Changed
- ...

## Architecture Decisions
- ...

## Reusable Components
- ...

## Tests
- ...

## Validation
- dart format: PASS/FAIL
- flutter analyze: PASS/FAIL
- flutter test: PASS/FAIL
- Files >500 lines: NONE / LIST

## Known Issues
- ...

## Next Recommended Step
- ...
```

## 18. Final Principle

Optimize for:

**Clarity + Maintainability + Trust + Performance + Real-world usefulness**

not:

**More code + More decoration + More abstractions + More animation**

When in doubt, choose the simpler implementation that preserves the business requirement.
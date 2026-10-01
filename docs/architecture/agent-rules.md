# Farmer Market Platform — Flutter Agent Rules

**Document purpose:** Non-negotiable rules for AI coding agents and human developers building the Farmer Market Platform.

**Primary stack:** Flutter + Dart  
**Architecture:** Clean Architecture + Feature-First  
**Application model:** One mobile app with role-based experiences for Farmer, Buyer, and Transporter. Admin/operations is a separate web application using the same backend.

---

## 1. Core Product Principle

The product exists to help farmers make better-informed selling decisions and complete the journey from production to payment with as little friction as possible.

The mobile application must feel:

- calm
- trustworthy
- practical
- fast
- modern
- human
- agricultural/business oriented

It must **not** feel like an AI-generated template.

### Never optimize for visual novelty

Do not add UI elements simply because they look impressive.

Every component must answer at least one of these questions:

1. Does it help the user understand something?
2. Does it help the user make a decision?
3. Does it help the user complete an action?
4. Does it communicate important status or risk?

If the answer is no, remove it.

---

# 2. Non-Negotiable Rules

Agents MUST follow these rules unless an explicit project decision overrides them.

### Architecture

- Use **Clean Architecture**.
- Organize the application **feature-first**, not layer-first.
- Business rules must not depend on Flutter widgets.
- Presentation must not contain database, HTTP, or business logic.
- Domain must remain framework-independent wherever practical.
- Data sources must be hidden behind repositories.
- Dependency direction must always point inward.

### File size

**No Dart source file may exceed 500 lines.**

This is a hard limit.

If a file approaches 400 lines, stop and consider extracting:

- widgets
- models
- mappers
- validators
- controllers/notifiers
- helpers
- sections
- use cases

Do not solve the problem by simply compressing formatting.

### UI

- Prefer simple layouts over decorative layouts.
- Avoid gradients by default.
- Avoid excessive rounded cards.
- Avoid excessive shadows.
- Avoid unnecessary icons.
- Avoid oversized illustrations.
- Avoid animated decoration.
- Avoid glassmorphism unless a specific product decision requires it.
- Avoid excessive badges and chips.
- Avoid emoji as interface decoration.
- Do not use icons where typography or spacing communicates the information better.
- Use color primarily for meaning: status, action, warning, success, error.
- One primary visual hierarchy per screen.
- Every screen must have a clear primary action.

### Performance

- Prefer const widgets.
- Avoid unnecessary rebuilds.
- Keep state as local as possible.
- Do not introduce global state for local UI state.
- Avoid rebuilding large widget trees for small state changes.
- Use lazy lists for potentially large collections.
- Never render an unbounded collection with `Column`.
- Dispose controllers, subscriptions, and animation resources correctly.
- Do not perform expensive work in `build()`.
- Do not perform network calls directly from widgets.
- Cache appropriate read-heavy data.
- Use image caching/resizing appropriately.
- Do not add packages without a clear reason.

---

# 3. Architecture

Use this dependency direction:

```text
Presentation
     ↓
Domain
     ↓
Data
```

Infrastructure implementations live in Data.

The Domain layer must not import:

- Flutter UI packages
- Dio/http clients
- database packages
- Firebase implementations
- SharedPreferences implementations
- platform-specific code

Presentation may depend on Domain.

Data may depend on Domain.

Domain must not depend on Data.

---

# 4. Feature-First Structure

Use:

```text
lib/
├── app/
│   ├── app.dart
│   ├── router/
│   └── bootstrap/
│
├── core/
│   ├── error/
│   ├── network/
│   ├── storage/
│   ├── theme/
│   ├── localization/
│   ├── utils/
│   └── widgets/
│
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
│
└── main.dart
```

Each feature owns its implementation.

Example:

```text
features/market_prices/
├── data/
│   ├── datasources/
│   ├── models/
│   ├── mappers/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
│
└── presentation/
    ├── pages/
    ├── widgets/
    ├── state/
    └── providers/
```

Do not create:

```text
lib/
├── screens/
├── widgets/
├── models/
├── services/
├── repositories/
└── controllers/
```

That structure becomes difficult to maintain as the product grows.

---

# 5. Feature Boundaries

A feature should own its:

- entities
- use cases
- repository contracts
- data models
- data sources
- state management
- screens
- feature-specific widgets

Do not place feature-specific logic in `core/`.

`core/` is only for genuinely shared infrastructure or components.

If something is used by only one feature, keep it inside that feature.

---

# 6. Core vs Shared Components

Create a shared component only when there is a real reuse case.

Good shared components:

```text
AppButton
AppTextField
AppLoading
AppErrorState
AppEmptyState
AppBottomSheet
AppDialog
PriceText
StatusBadge
```

Bad abstraction:

```text
UniversalCardBuilder<T>
GenericScreenRenderer
DynamicEverythingWidget
BaseEverythingController
```

Do not create abstractions merely to reduce duplicate lines.

### Rule

**Reuse behavior and design language, not every visual fragment.**

If two screens look slightly different because they solve different problems, allow them to be different.

---

# 7. Reusability Without Performance Damage

Reusable widgets must remain cheap.

Prefer:

```dart
const AppButton(...)
```

over reusable widgets that contain unnecessary:

- animations
- controllers
- listeners
- inherited state
- streams
- rebuild triggers

A reusable component should not introduce state unless the component genuinely owns that state.

Prefer composition:

```text
PriceCard
 ├── PriceHeader
 ├── PriceValue
 └── PriceMetadata
```

over a giant configurable widget:

```text
SuperCard(
  type: ...,
  variant: ...,
  showIcon: ...,
  showBadge: ...,
  ...
)
```

When configuration becomes difficult to understand, split the component.

---

# 8. State Management

Use the project's chosen state-management solution consistently.

Do not mix multiple state-management systems without an explicit architectural reason.

Separate:

### UI state

Examples:

- selected tab
- expanded section
- loading button
- text input state

### Application state

Examples:

- authenticated user
- active order
- farmer profile
- current market prices

### Domain state

Examples:

- order status
- payment status
- sale agreement
- produce availability

Business rules belong outside widgets.

---

# 9. Use Cases

Use cases should represent meaningful business actions.

Good:

```text
GetMarketPrices
CompareMarkets
CreateProduceListing
AcceptBuyerOffer
CreateOrder
ConfirmPickup
ConfirmDelivery
RecordSale
GetFarmerSales
```

Avoid meaningless use cases such as:

```text
GetData
ProcessData
HandleScreen
DoSomething
```

A use case should have one clear responsibility.

---

# 10. Repository Rules

Domain defines repository contracts.

Example:

```dart
abstract interface class MarketPriceRepository {
  Future<Result<List<MarketPrice>>> getCurrentPrices(
    MarketPriceQuery query,
  );
}
```

Data implements the contract.

The UI must never know whether data came from:

- REST API
- local database
- cache
- network
- mock data

That decision belongs to Data.

---

# 11. Offline-First Thinking

Farmers may have unreliable connectivity.

Every important feature should define:

```text
Online behavior
Offline behavior
Sync behavior
Failure behavior
```

For example:

### Market prices

Online:

```text
Fetch latest prices
↓
Cache locally
↓
Display timestamp
```

Offline:

```text
Read cached prices
↓
Show "Last updated ..."
```

Never display cached data as if it were live.

---

# 12. API and Data Rules

Never expose API response models directly to presentation.

Use:

```text
API DTO
   ↓
Mapper
   ↓
Domain Entity
   ↓
Presentation Model/View State
```

Do not spread JSON field names throughout widgets.

Bad:

```dart
json['current_price']
```

inside UI code.

Good:

```dart
marketPrice.amount
```

---

# 13. Error Handling

Errors must be meaningful to users.

Do not show:

```text
Exception: DioException...
```

Instead:

```text
We couldn't load market prices.
Check your connection and try again.
```

Technical details belong in logs, not user-facing UI.

Every async screen must consider:

```text
Loading
Success
Empty
Error
Offline
```

---

# 14. UI Design System

Create a small, deliberate design system.

Define:

- typography
- spacing scale
- radius scale
- colors
- elevation
- button styles
- input styles
- status styles

Avoid dozens of one-off values.

Prefer a spacing scale such as:

```text
4
8
12
16
20
24
32
40
48
```

Use a small radius scale.

Do not make every element a rounded rectangle.

---

# 15. Visual Style Rules

The design should communicate:

**Agriculture + marketplace + trust + utility**

It should not communicate:

**AI dashboard + crypto app + gaming interface**

### Prefer

- strong typography
- generous whitespace
- clear sections
- restrained color
- simple cards
- subtle borders
- clear numbers
- meaningful status colors
- real product photography only where it adds value

### Avoid

- gradient backgrounds
- neon colors
- floating decorative shapes
- excessive blobs
- excessive glass effects
- random illustrations
- 3D decorations
- huge icons
- excessive shadows
- excessive micro-interactions
- meaningless animations

---

# 16. Icons

Icons must communicate meaning.

Good:

```text
Search
Location
Calendar
Arrow
Check
Warning
Truck
Wallet
```

Do not add an icon to every row merely because there is empty space.

A label such as:

```text
Current price
TZS 1,580/kg
```

may not need an icon.

Use icons consistently.

Do not mix unrelated icon styles.

---

# 17. Color Rules

Use a restrained palette.

Recommended semantic roles:

```text
Primary
Secondary
Surface
Background
Text
Muted text
Border
Success
Warning
Error
Info
```

Do not introduce a new color for every feature.

Color must communicate meaning.

Example:

```text
Green  → completed / positive
Amber  → attention / pending
Red    → error / risk
Blue   → informational
```

Do not rely on color alone. Pair color with text or another visual cue.

---

# 18. Typography

Numbers are important in this application.

Prices, quantities and totals should have strong visual hierarchy.

Example:

```text
Current market price

TZS 1,580
per kg
```

The price should be visually stronger than supporting information.

Avoid excessive font sizes.

Typography should do more work than decorative UI.

---

# 19. Screen Design Rule

Before implementing a screen, define:

```text
Screen purpose:
Primary user:
Primary decision:
Primary action:
Important supporting information:
Empty state:
Loading state:
Error state:
Offline state:
```

If the purpose cannot be explained in one or two sentences, the screen is probably doing too much.

---

# 20. Dashboard/Home Screen

Do not turn the home screen into a collection of cards.

A farmer's home screen should answer:

1. What matters today?
2. What is the current market situation?
3. What action should I take next?
4. Is something waiting for me?

Example structure:

```text
Greeting
↓
Important market information
↓
Primary action
↓
Active transaction/status
↓
Relevant alerts
```

Not:

```text
12 cards
8 statistics
17 icons
4 charts
```

---

# 21. Navigation

Navigation should reflect user goals.

Farmer example:

```text
Home
Market
Sell
Orders
Profile
```

Buyer example:

```text
Home
Find Produce
Orders
Messages
Profile
```

Transporter example:

```text
Jobs
Active Trip
History
Profile
```

Do not expose features that the current role cannot use.

---

# 22. Role-Based Access

Roles are a domain/security concern, not merely a UI concern.

The app must not rely only on hiding buttons.

Backend authorization must independently enforce permissions.

For example:

```text
Farmer
  → can create own listing

Buyer
  → can create buying request

Transporter
  → can update assigned delivery

Admin
  → can manage platform data
```

Never trust role information sent by the client.

---

# 23. Forms

Forms must be simple.

Rules:

- clear labels
- sensible keyboard types
- validation close to the field
- preserve entered data when possible
- do not use browser-style alerts
- use proper dialogs/sheets for destructive actions
- confirm destructive actions before discarding meaningful user input
- show progress during network operations
- prevent accidental duplicate submissions

Do not ask for information that the platform can derive.

---

# 24. Lists

For large data:

```dart
ListView.builder
```

or equivalent lazy rendering must be used.

Do not load thousands of:

- prices
- buyers
- orders
- transactions
- notifications

into memory unnecessarily.

Use pagination where appropriate.

---

# 25. Search and Filtering

Search should be server-side when datasets become large.

Filtering must have predictable behavior.

Avoid building complicated filter UIs for a feature with only two or three meaningful choices.

Prefer:

```text
Crop
Location
Price
Distance
Availability
```

only when these filters actually affect the user's decision.

---

# 26. Charts

Charts are not decoration.

Only add a chart if it answers a useful question.

Good:

```text
Rice price over the last 30 days
```

Bad:

```text
Random colorful dashboard chart
```

Keep charts simple and readable.

---

# 27. Animation

Animation should communicate:

- transition
- progress
- state change
- confirmation

Avoid animation purely for entertainment.

Prefer short, subtle animations.

Never make the application feel slow because of animation.

Respect reduced-motion/accessibility settings where applicable.

---

# 28. Accessibility

Every important interaction must work with:

- readable text
- sufficient contrast
- semantic labels
- screen readers
- large enough touch targets
- predictable navigation

Do not communicate important information only through color.

---

# 29. Localization

The architecture must support localization from the beginning.

Do not hard-code user-facing strings throughout widgets.

Keep text in localization resources.

The initial language may be English, but the architecture should allow Swahili without rewriting features.

---

# 30. Performance Rules

Before adding a dependency, ask:

1. Can Flutter/Dart already do this?
2. Is the dependency maintained?
3. Does it materially reduce complexity?
4. Does it increase application size?
5. Does it introduce unnecessary runtime work?

Do not add a package for trivial functionality.

### Build performance

Avoid:

```dart
setState(() {});
```

around large trees when only a small section needs updating.

Prefer smaller stateful boundaries.

Use:

```dart
const
```

whenever possible.

Use keys deliberately, not everywhere.

Do not optimize prematurely, but do not introduce obvious rebuild problems.

---

# 31. Networking

Network calls must not happen directly inside `build()`.

Do not write:

```dart
Widget build(...) {
  repository.getPrices();
}
```

Use state/application lifecycle mechanisms.

Handle:

- timeout
- no internet
- server error
- unauthorized
- validation error
- rate limiting
- retryable failures

Retries must not create duplicate transactions.

---

# 32. Transactions and Idempotency

Financial and marketplace actions require special care.

Operations such as:

```text
Create order
Accept offer
Confirm delivery
Record payment
```

must be protected against accidental duplicate submission.

Use server-side idempotency where appropriate.

The UI should disable or otherwise protect the action while the request is processing.

Never assume:

```text
button tapped once = request executed once
```

---

# 33. Logging

Logs must help developers diagnose problems without leaking sensitive data.

Never log:

- passwords
- authentication tokens
- PINs
- full payment credentials
- unnecessary personal information

Use structured logs where practical.

---

# 34. Testing

Every feature must have appropriate tests.

### Domain

Unit test:

- business rules
- use cases
- validation
- calculations

### Data

Test:

- DTO parsing
- mapping
- repository behavior
- API error handling
- cache behavior

### Presentation

Test:

- loading
- success
- empty
- error
- user actions
- important navigation behavior

Critical marketplace and payment flows should have integration/widget coverage.

---

# 35. Feature Development Workflow

AI agents MUST follow this order.

## Step 1 — Understand

Before coding:

- inspect existing architecture
- inspect related features
- inspect design system
- inspect routing
- inspect state management
- inspect API contracts
- identify reusable components

Do not immediately create files.

## Step 2 — Plan

Write a short implementation plan:

```text
Feature:
User goal:
Domain entities:
Use cases:
Repository changes:
API/data changes:
Screens:
Reusable components:
Tests:
Potential risks:
```

## Step 3 — Implement Domain

Create:

- entities
- value objects where useful
- repository contracts
- use cases

## Step 4 — Implement Data

Create:

- DTO/models
- data sources
- mappers
- repository implementations

## Step 5 — Implement Presentation

Create:

- state
- pages
- feature widgets
- interactions

## Step 6 — Integrate

Update:

- routing
- dependency injection
- localization
- navigation
- permissions

## Step 7 — Test

Run:

```text
dart format
flutter analyze
flutter test
```

Also run relevant integration tests.

## Step 8 — Review

Check:

- architecture
- file sizes
- duplicated logic
- unnecessary dependencies
- unnecessary rebuilds
- accessibility
- loading/error/empty states
- role permissions
- offline behavior

---

# 36. AI Agent Behavior Rules

AI agents must NOT:

- rewrite unrelated files
- refactor the entire application while implementing one feature
- introduce new architecture without approval
- create duplicate components
- create duplicate services
- create giant widgets
- bypass repository abstractions
- put API calls inside widgets
- hard-code API URLs throughout the app
- hard-code user-facing strings
- add packages casually
- ignore analyzer warnings
- leave TODO placeholders for core functionality
- silently change existing behavior
- delete working code merely to simplify implementation
- generate mock functionality and present it as production-ready
- exceed the 500-line file limit

If an agent discovers architectural debt outside its task:

```text
Document it.
Do not silently perform a large unrelated refactor.
```

---

# 37. File Size Enforcement

Before finishing any task, agents must check:

```bash
find lib -name "*.dart" -print0 | xargs -0 wc -l | sort -nr | head -30
```

Any file above 500 lines is a failed implementation.

Preferred target:

```text
< 300 lines
```

The 500-line rule is the maximum, not the goal.

---

# 38. Naming

Use descriptive names.

Good:

```text
MarketPriceRepository
GetCurrentMarketPrices
CreateProduceListing
ConfirmDelivery
FarmerHomePage
MarketPriceCard
```

Avoid:

```text
DataManager
CommonService
Helper
Utils2
Thing
Temp
NewWidget
```

Do not use abbreviations unless they are widely understood in the domain.

---

# 39. Comments

Write comments to explain **why**, not what the code obviously does.

Bad:

```dart
// Get prices
final prices = await repository.getPrices();
```

Good:

```dart
// Cached prices are intentionally returned when offline so farmers
// can still make decisions using clearly timestamped market data.
```

Do not use comments to compensate for poorly structured code.

---

# 40. Git Discipline

A feature should be easy to review.

Prefer small commits such as:

```text
feat(market-prices): add market price domain
feat(market-prices): add API repository
feat(market-prices): add price comparison screen
test(market-prices): add repository tests
```

Do not mix:

```text
feature + unrelated redesign + dependency upgrade + formatting
```

in one commit.

---

# 41. Definition of Done

A feature is NOT complete until:

### Architecture

- [ ] Feature is in the correct feature folder.
- [ ] Domain does not depend on infrastructure.
- [ ] Repository contract is in Domain.
- [ ] Repository implementation is in Data.
- [ ] Business logic is not in widgets.
- [ ] No inappropriate cross-feature coupling exists.

### Code

- [ ] No Dart file exceeds 500 lines.
- [ ] Preferably files remain below 300 lines.
- [ ] Naming is clear.
- [ ] No unnecessary abstractions.
- [ ] No duplicated business logic.
- [ ] No unnecessary package added.

### UI

- [ ] Clear primary action.
- [ ] Clean visual hierarchy.
- [ ] No unnecessary gradients.
- [ ] No decorative icon overload.
- [ ] No excessive cards.
- [ ] No excessive shadows.
- [ ] No unnecessary animation.
- [ ] Typography carries the hierarchy.
- [ ] UI looks intentional rather than generated.

### State

- [ ] Loading state exists.
- [ ] Success state exists.
- [ ] Empty state exists.
- [ ] Error state exists.
- [ ] Offline behavior is defined where relevant.

### Performance

- [ ] Const widgets used where practical.
- [ ] Large lists are lazy.
- [ ] No expensive work in `build()`.
- [ ] No unnecessary global state.
- [ ] No obvious rebuild problems.

### Security

- [ ] Backend authorization is respected.
- [ ] Sensitive data is not logged.
- [ ] Financial actions are protected against duplicate submission.
- [ ] Client-side role checks are not treated as security boundaries.

### Quality

- [ ] `dart format` passes.
- [ ] `flutter analyze` passes.
- [ ] Relevant tests pass.
- [ ] Feature behavior has been manually reviewed.
- [ ] No unrelated behavior was changed.

---

# 42. Design Review Questions

Before approving any screen, ask:

### Purpose

> Can I explain what this screen is for in one sentence?

### Hierarchy

> Can I immediately identify the most important information?

### Action

> Is the next action obvious?

### Simplicity

> Can anything be removed without reducing usefulness?

### Authenticity

> Does this look like a real agricultural marketplace product rather than an AI-generated UI concept?

### Trust

> Does the screen clearly communicate price freshness, transaction status, and important uncertainty?

### Performance

> Will this remain fast with thousands of records?

If the answer is no, revise the design before implementation.

---

# 43. Product-Specific UX Rules

For market prices:

Always show:

```text
Price
Unit
Location/market
Commodity/grade
Timestamp
Source or price type where applicable
```

Never show a price without enough context to understand it.

For buyer offers:

Show:

```text
Quantity
Price
Quality/grade
Location
Expected delivery
Payment terms
Offer status
```

For transport:

Show:

```text
Pickup
Destination
Cargo
Driver/transporter
Status
Estimated timing
```

For transactions:

Show a clear lifecycle:

```text
Created
→ Accepted
→ Preparing
→ Picked up
→ In transit
→ Delivered
→ Verified
→ Paid
→ Completed
```

Do not make users guess what happened to their produce or money.

---

# 44. Final Agent Principle

The agent must optimize for:

```text
Clarity
+
Maintainability
+
Trust
+
Performance
+
Real-world usefulness
```

Not:

```text
More components
+
More animation
+
More colors
+
More abstractions
+
More code
```

The best implementation is the simplest implementation that correctly solves the user's problem and remains maintainable as the platform grows.

---

# 45. Required Agent Response After Implementation

When an AI agent completes a feature, it must report:

```text
## Implemented

- What was built
- Files added/changed
- Architecture decisions
- Reusable components added
- API/data changes
- Tests added

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

Never claim a validation command passed unless it was actually executed.s
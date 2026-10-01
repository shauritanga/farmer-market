# Fama — Mobile App

Flutter app for Farmer / Buyer / Transporter workflows. Part of the `farmer-market`
monorepo — see the root `README.md` and `AGENTS.md` before making changes.

## Stack

- State/DI: `flutter_riverpod` · Routing: `go_router`
- Theming: `flex_color_scheme` (seeded from the agricultural-green brand color,
  see `lib/core/theme/app_theme.dart`) + `google_fonts` (Inter)
- Icons: `hugeicons` — always use `HugeIcon(icon: HugeIcons.strokeRoundedXxx, ...)`,
  never the Material `Icon`/`Icons.*` widgets
- Responsiveness: `flutter_screenutil` — size with `.w`/`.h`/`.sp`/`.r`, not raw
  pixel values (see any existing widget for the convention)
- Note: because `flex_color_scheme` is built against the separate `material_ui`
  pub package, this app imports `package:material_ui/material_ui.dart` instead
  of `package:flutter/material.dart` everywhere — mixing the two causes
  `ThemeData` type-mismatch errors
- First-run flow: `lib/features/onboarding` (3 pages, persisted via
  `shared_preferences`) gates everything else via `go_router` redirect —
  see `lib/app/router/app_router.dart`

## Getting started

```bash
flutter pub get
flutter run --dart-define=API_BASE_URL=http://localhost:3000
```

## Validation

```bash
dart format .
flutter analyze
flutter test
```

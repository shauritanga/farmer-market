# Claude Code Instructions

`../../AGENTS.md` is the canonical engineering, architecture, UI, performance, and quality rulebook for this project (applies to all apps, not just mobile).

Before making changes:

1. Read `../../AGENTS.md`.
2. Read the relevant files under `../../docs/`.
3. Inspect existing code before creating new abstractions.
4. Follow the existing architecture unless a documented decision changes it.

Do not duplicate the full rules here.

The 500-line Dart-file maximum is mandatory.

## Stack conventions (see `README.md` for the full list)

- Import `package:material_ui/material_ui.dart`, never
  `package:flutter/material.dart` — `flex_color_scheme` (our theming package)
  returns a `ThemeData` from `material_ui`, which is a *different type* than
  Flutter SDK's own `ThemeData`. Mixing the two imports causes
  `return_of_invalid_type` / `argument_type_not_assignable` errors that look
  unrelated to theming. `material_ui` re-exports everything
  `flutter/material.dart` and `flutter/widgets.dart` do, so it's a safe
  drop-in for every file.
- Localization delegates in `app/app.dart` follow the same rule:
  `GlobalMaterialLocalizations` from `material_ui`, `GlobalCupertinoLocalizations`
  from its sibling `cupertino_ui` package, and only `GlobalWidgetsLocalizations`
  genuinely from `flutter_localizations`. Mixing the SDK's Cupertino delegate
  with material_ui's Material delegate produces a runtime "locale not
  supported by all delegates" warning that fails `flutter test` even when the
  locale is actually supported everywhere.
- Icons: `HugeIcon(icon: HugeIcons.strokeRoundedXxx, ...)` from `hugeicons` —
  never `Icon(Icons.xxx)`.
- Sizing: ScreenUtil's `.w` / `.h` / `.sp` / `.r` extensions, not raw pixels.
  `AppTheme.light()`/`.dark()` call `.sp` internally, so they must only be
  invoked inside `ScreenUtilInit`'s `builder` (see `app/app.dart`).
- User-facing strings: add keys to `lib/l10n/app_sw.arb` (canonical/default —
  Swahili is the default locale) and `lib/l10n/app_en.arb`, then
  `flutter gen-l10n` (or `flutter pub get`, since `generate: true`). Use via
  `AppLocalizations.of(context)!.yourKey` — never hardcode user-facing copy.
- Role-aware home screens: `features/home/presentation/pages/home_page.dart`
  is a thin role dispatcher only — it picks a shell by `UserRole` and renders
  nothing itself. Each role's actual bottom-nav shell + its role-specific
  composite screens (an overview tab, a "more" tab, etc. — not real domain
  features) live in their own subfolder: `presentation/farmer/`,
  `presentation/buyer/`, `presentation/transporter/`. Domain tabs (Market,
  Produce, Orders, ...) are NOT role-specific and stay in their own
  top-level feature folders (`features/market_prices/`, etc.) regardless of
  which role's shell links to them — don't duplicate them per role.

Do not perform unrelated refactors. If you discover architectural debt outside the requested task, document it instead of silently changing it.

Before completion, run the applicable validation commands and report actual results.

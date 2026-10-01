# Claude Code Instructions — Web (Admin Dashboard)

`../../AGENTS.md` and `../../docs/` are canonical — read them first. This app is the
"Admin/Operations" web application referenced there: user/verification management,
market data administration, order oversight, dispute handling.

## Stack

React + TypeScript + Vite, React Router, TanStack Query, axios.

## Structure

```text
src/
├── app/            root App, router wiring, ProtectedRoute, query client
├── core/
│   ├── api/         shared axios instance
│   ├── auth/         AuthContext, token storage
│   └── components/   shared UI primitives (Button, *State, StatusBadge, AppLayout)
└── features/
    └── <feature>/     pages + feature-local API calls
```

Feature-first, same reasoning as the mobile app: a feature's own API/page code lives
with the feature, not in `core/`. Only promote something to `core/` when at least two
features genuinely need it.

## Rules

- Role-based UI is not security — every admin action still needs backend
  authorization; don't assume a rendered button implies permission.
- Every async view defines loading / error / empty states (see `core/components`) —
  don't render a blank screen while data loads.
- Never put personal or sensitive data in the URL.

## Validation

Before declaring a change complete, actually run and report:

```bash
npm run build --workspace apps/web
npm run lint --workspace apps/web
```

If you can run a browser (Claude in Chrome or similar), smoke-test the actual golden
path — a build passing is not the same as the feature working.

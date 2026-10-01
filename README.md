# Fama — Farmer Market Platform

A digital marketplace and operating layer for farmers, buyers, and transporters —
see `docs/product/product-spec.md` for the full product vision.

## Structure

```text
apps/
├── mobile/    Flutter — Farmer / Buyer / Transporter app
├── web/       React + TypeScript — Admin / Operations dashboard
└── backend/   NestJS + Prisma + PostgreSQL — shared API
docs/          Product spec, architecture, API boundaries (read before changing anything)
infra/         Local dev infrastructure (PostgreSQL via Docker Compose)
```

Read `AGENTS.md` before making non-trivial changes — it's the canonical rulebook for
architecture, UX, and data-integrity conventions across all three apps.

## Prerequisites

- Node.js 20+ and npm 10+
- Docker (for local PostgreSQL) — or point `DATABASE_URL` at your own instance
- Flutter SDK (for the mobile app)

## Getting started

### 1. Install JS dependencies (web + backend, via npm workspaces)

```bash
npm install
```

### 2. Start PostgreSQL

```bash
npm run db:up          # docker compose up -d, exposes Postgres on localhost:5433
```

### 3. Backend

```bash
cp apps/backend/.env.example apps/backend/.env   # already present with dev defaults
npm run db:migrate                               # applies prisma/schema.prisma
npm run dev:backend                              # http://localhost:3000
```

### 4. Web dashboard

```bash
cp apps/web/.env.example apps/web/.env           # already present with dev defaults
npm run dev:web                                  # http://localhost:5173
```

### 5. Mobile app

```bash
cd apps/mobile
flutter pub get
flutter run --dart-define=API_BASE_URL=http://localhost:3000
```

## Validation

```bash
# Backend
npm run build --workspace apps/backend
npm run lint --workspace apps/backend
npm run test --workspace apps/backend

# Web
npm run build --workspace apps/web
npm run lint --workspace apps/web

# Mobile
cd apps/mobile && dart format . && flutter analyze && flutter test
```

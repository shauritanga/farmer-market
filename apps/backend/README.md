# Fama — Backend API

NestJS + Prisma + PostgreSQL. Part of the `farmer-market` monorepo — see the root
`README.md` and `AGENTS.md`, and this folder's `CLAUDE.md` for stack-specific rules.

## Getting started

```bash
# from the repo root
npm run db:up
npm run db:migrate
npm run dev:backend        # http://localhost:3000
```

## Validation

```bash
npm run build --workspace apps/backend
npm run lint --workspace apps/backend
npm run test --workspace apps/backend
```

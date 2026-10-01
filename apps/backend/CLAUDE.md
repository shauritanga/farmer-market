# Claude Code Instructions — Backend

`../../AGENTS.md` and `../../docs/` are canonical — read them first, especially
`docs/api/api-boundaries.md` and the price/order/payment integrity rules.

## Stack

NestJS + Prisma (driver adapter, not the implicit `url` in schema.prisma) + PostgreSQL.

## Structure

```text
src/
├── common/        guards, decorators — genuine cross-module concerns only
├── prisma/         PrismaService/PrismaModule (global)
└── modules/
    └── <feature>/
        ├── <feature>.module.ts
        ├── <feature>.controller.ts
        ├── <feature>.service.ts
        └── dto/
```

One module per API boundary in `docs/api/api-boundaries.md` (auth, market-prices,
produce, buyers, orders, logistics, payments, notifications). Don't collapse
unrelated boundaries into one module for convenience.

## Phone numbers

Every DTO with a `phoneNumber` field (`send-code`, `verify-code`, `register`, `login`)
must use `@Transform(({ value }) => normalizePhoneNumber(value))` from
`modules/auth/utils/normalize-phone.util.ts` followed by `@IsPhoneNumber('TZ')` — this
is what lets the client send `0712345678`, `255712345678`, or `+255712345678`
interchangeably; without the transform, only the `+255...` form validates. Do this on
any *new* endpoint that takes a phone number too, not just auth's.

## SMS (Beem)

`modules/auth/verification-provider.service.ts` sends real SMS via Beem — same
account/credentials as the sibling RealMoney project (`ONBOARDING_DEV_MODE=false` in
`.env` for live sending; `true` bypasses Beem entirely and returns the code in the
response as `developmentCode` instead, for local dev without spending SMS credits).
Never log the raw OTP code server-side — `PhoneVerificationService` stores only an
HMAC hash (`OTP_SECRET`).

## Rules

- Backend authorization is authoritative — never trust a client-supplied role.
  Every mutating endpoint must verify the caller's actual role/ownership server-side.
- Order/payment status transitions are server-owned. Clients display them; they never
  invent a later status locally.
- A price response always carries freshness metadata (`recordedAt`, `priceType`,
  `source`) — never return a bare number.
- Critical mutations (orders, payments) need idempotency before they're production-ready.
- Never log passwords, tokens, or payment credentials.

## Validation

Before declaring a change complete, actually run and report:

```bash
npm run build --workspace apps/backend
npm run lint --workspace apps/backend
npm run test --workspace apps/backend
```

If the change touches `prisma/schema.prisma`, also run `npx prisma format` and
`npx prisma migrate dev` (backend needs Postgres reachable — see root README for
`npm run db:up`) and report the migration that was generated.

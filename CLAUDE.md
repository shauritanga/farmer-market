# Claude Code Instructions

This is a monorepo: `apps/mobile` (Flutter), `apps/web` (React + TypeScript admin
dashboard), `apps/backend` (NestJS + Prisma + PostgreSQL API).

Before making changes:

1. Read `AGENTS.md` — canonical rules for all three apps.
2. Read the relevant files under `docs/` (product spec, architecture, API boundaries).
3. Read the `CLAUDE.md` inside the specific app you're changing (`apps/mobile`,
   `apps/web`, `apps/backend`) for stack-specific conventions.
4. Inspect existing code before creating new abstractions.

Do not perform unrelated refactors across apps. If you discover architectural debt
outside the requested task, document it instead of silently changing it.

Before completion, run the applicable validation commands for whichever app(s) you
touched and report actual results — never claim a command passed without running it.

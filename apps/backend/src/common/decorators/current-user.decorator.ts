import { createParamDecorator, ExecutionContext } from '@nestjs/common';

import type { AuthenticatedRequest } from '../guards/jwt-auth.guard.js';

/**
 * Usage: `@CurrentUser() user: { sub: string; role: string }` in a
 * controller method guarded by [JwtAuthGuard].
 */
export const CurrentUser = createParamDecorator(
  (_: unknown, ctx: ExecutionContext) => {
    const request = ctx.switchToHttp().getRequest<AuthenticatedRequest>();
    return request.user;
  },
);

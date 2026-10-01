import { Global, Module } from '@nestjs/common';

import { PrismaService } from './prisma.service.js';

/**
 * Global so feature modules can inject PrismaService without each
 * re-importing this module — the database connection is a genuine
 * cross-cutting concern, same reasoning as `core/` on the mobile app.
 */
@Global()
@Module({
  providers: [PrismaService],
  exports: [PrismaService],
})
export class PrismaModule {}

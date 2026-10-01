import { Injectable } from '@nestjs/common';

import { PrismaService } from '../../prisma/prisma.service.js';

@Injectable()
export class OrdersService {
  constructor(private readonly prisma: PrismaService) {}

  /**
   * Orders where the given user is the buyer or the farmer. Role-based UI
   * is not security (AGENTS.md §9) — this still filters by the caller's
   * own userId, but a real implementation must also verify role server-side
   * on any mutating endpoint.
   */
  async findForUser(userId: string) {
    return this.prisma.order.findMany({
      where: {
        OR: [
          { buyer: { userId } },
          { farmer: { userId } },
        ],
      },
      orderBy: { createdAt: 'desc' },
      include: {
        commodity: true,
        statusEvents: { orderBy: { createdAt: 'asc' } },
      },
    });
  }
}

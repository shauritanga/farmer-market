import { Injectable } from '@nestjs/common';

import { PrismaService } from '../../prisma/prisma.service.js';

@Injectable()
export class BuyersService {
  constructor(private readonly prisma: PrismaService) {}

  /**
   * Open buyer requests, newest first, for farmers to browse. Only the
   * buyer fields a farmer needs to evaluate a request are returned —
   * never auth/internal user fields (no `include: { user: true }` here:
   * that would leak password hashes to every farmer).
   */
  findOpenDemand() {
    return this.prisma.buyerDemand.findMany({
      where: { status: 'OPEN' },
      orderBy: { createdAt: 'desc' },
      include: {
        commodity: true,
        buyer: {
          select: {
            id: true,
            businessName: true,
            user: { select: { id: true, name: true } },
          },
        },
      },
    });
  }
}

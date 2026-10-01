import { Injectable } from '@nestjs/common';

import { PrismaService } from '../../prisma/prisma.service.js';

@Injectable()
export class ProduceService {
  constructor(private readonly prisma: PrismaService) {}

  findActive() {
    return this.prisma.produceListing.findMany({
      where: { status: 'ACTIVE' },
      orderBy: { createdAt: 'desc' },
      include: { commodity: true, farmer: { include: { user: true } } },
    });
  }

  /** The calling farmer's own listings, any status — not just ACTIVE. */
  findMine(userId: string) {
    return this.prisma.produceListing.findMany({
      where: { farmer: { userId } },
      orderBy: { createdAt: 'desc' },
      include: { commodity: true },
    });
  }
}

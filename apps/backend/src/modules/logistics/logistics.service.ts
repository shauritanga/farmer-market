import { Injectable } from '@nestjs/common';

import { PrismaService } from '../../prisma/prisma.service.js';

@Injectable()
export class LogisticsService {
  constructor(private readonly prisma: PrismaService) {}

  findAssignedTo(transporterUserId: string) {
    return this.prisma.transportJob.findMany({
      where: { transporter: { userId: transporterUserId } },
      orderBy: { createdAt: 'desc' },
      include: { order: true, events: { orderBy: { createdAt: 'asc' } } },
    });
  }
}

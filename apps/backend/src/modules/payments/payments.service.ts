import { Injectable } from '@nestjs/common';

import { PrismaService } from '../../prisma/prisma.service.js';

@Injectable()
export class PaymentsService {
  constructor(private readonly prisma: PrismaService) {}

  /**
   * The mobile/web clients must not independently decide a payment
   * succeeded — see docs/api/api-boundaries.md (Payments). This only
   * reads the status the payment provider last confirmed.
   */
  findByOrder(orderId: string) {
    return this.prisma.payment.findUnique({ where: { orderId } });
  }
}

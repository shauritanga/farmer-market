import { Controller, Get, Param, UseGuards } from '@nestjs/common';

import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard.js';
import { PaymentsService } from './payments.service.js';

@Controller('payments')
@UseGuards(JwtAuthGuard)
export class PaymentsController {
  constructor(private readonly paymentsService: PaymentsService) {}

  @Get('by-order/:orderId')
  findByOrder(@Param('orderId') orderId: string) {
    return this.paymentsService.findByOrder(orderId);
  }
}

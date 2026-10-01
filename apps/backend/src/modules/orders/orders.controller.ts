import { Controller, Get, UseGuards } from '@nestjs/common';

import { CurrentUser } from '../../common/decorators/current-user.decorator.js';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard.js';
import { OrdersService } from './orders.service.js';

@Controller('orders')
@UseGuards(JwtAuthGuard)
export class OrdersController {
  constructor(private readonly ordersService: OrdersService) {}

  @Get('mine')
  findMine(@CurrentUser() user: { sub: string }) {
    return this.ordersService.findForUser(user.sub);
  }
}

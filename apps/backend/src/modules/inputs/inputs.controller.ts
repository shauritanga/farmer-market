import { Body, Controller, Get, Post, UseGuards } from '@nestjs/common';

import { CurrentUser } from '../../common/decorators/current-user.decorator.js';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard.js';
import { CreateInputOrderDto } from './dto/create-input-order.dto.js';
import { InputsService } from './inputs.service.js';

@Controller('inputs')
@UseGuards(JwtAuthGuard)
export class InputsController {
  constructor(private readonly inputsService: InputsService) {}

  @Get()
  findActive() {
    return this.inputsService.findActive();
  }

  @Post('orders')
  createOrder(
    @CurrentUser() user: { sub: string },
    @Body() dto: CreateInputOrderDto,
  ) {
    return this.inputsService.createOrder(user.sub, dto.inputId, dto.quantity);
  }

  @Get('orders/mine')
  findMine(@CurrentUser() user: { sub: string }) {
    return this.inputsService.findMine(user.sub);
  }
}

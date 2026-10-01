import { Controller, Get, UseGuards } from '@nestjs/common';

import { CurrentUser } from '../../common/decorators/current-user.decorator.js';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard.js';
import { ProduceService } from './produce.service.js';

@Controller('produce')
@UseGuards(JwtAuthGuard)
export class ProduceController {
  constructor(private readonly produceService: ProduceService) {}

  @Get('mine')
  findMine(@CurrentUser() user: { sub: string }) {
    return this.produceService.findMine(user.sub);
  }

  @Get()
  findActive() {
    return this.produceService.findActive();
  }
}

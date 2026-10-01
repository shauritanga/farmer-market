import { Controller, Get, UseGuards } from '@nestjs/common';

import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard.js';
import { BuyersService } from './buyers.service.js';

@Controller('buyer-demand')
@UseGuards(JwtAuthGuard)
export class BuyersController {
  constructor(private readonly buyersService: BuyersService) {}

  @Get()
  findOpenDemand() {
    return this.buyersService.findOpenDemand();
  }
}

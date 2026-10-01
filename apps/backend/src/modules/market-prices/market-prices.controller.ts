import { Controller, Get, Query, UseGuards } from '@nestjs/common';

import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard.js';
import { MarketPricesService } from './market-prices.service.js';

@Controller('market-prices')
@UseGuards(JwtAuthGuard)
export class MarketPricesController {
  constructor(private readonly marketPricesService: MarketPricesService) {}

  @Get('top')
  findTopMarket() {
    return this.marketPricesService.findTopMarket();
  }

  @Get()
  findCurrent(
    @Query('commodityId') commodityId?: string,
    @Query('marketId') marketId?: string,
  ) {
    return this.marketPricesService.findCurrent({ commodityId, marketId });
  }
}

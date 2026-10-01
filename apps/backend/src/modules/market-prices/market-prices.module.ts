import { Module } from '@nestjs/common';

import { MarketPricesController } from './market-prices.controller.js';
import { MarketPricesService } from './market-prices.service.js';

@Module({
  controllers: [MarketPricesController],
  providers: [MarketPricesService],
})
export class MarketPricesModule {}

import { Module } from '@nestjs/common';

import { LogisticsController } from './logistics.controller.js';
import { LogisticsService } from './logistics.service.js';

@Module({
  controllers: [LogisticsController],
  providers: [LogisticsService],
})
export class LogisticsModule {}

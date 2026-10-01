import { Module } from '@nestjs/common';

import { ProduceController } from './produce.controller.js';
import { ProduceService } from './produce.service.js';

@Module({
  controllers: [ProduceController],
  providers: [ProduceService],
})
export class ProduceModule {}

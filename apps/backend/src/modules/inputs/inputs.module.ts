import { Module } from '@nestjs/common';

import { InputsController } from './inputs.controller.js';
import { InputsService } from './inputs.service.js';

@Module({
  controllers: [InputsController],
  providers: [InputsService],
})
export class InputsModule {}

import { Controller, Get, UseGuards } from '@nestjs/common';

import { CurrentUser } from '../../common/decorators/current-user.decorator.js';
import { JwtAuthGuard } from '../../common/guards/jwt-auth.guard.js';
import { LogisticsService } from './logistics.service.js';

@Controller('transport-jobs')
@UseGuards(JwtAuthGuard)
export class LogisticsController {
  constructor(private readonly logisticsService: LogisticsService) {}

  @Get('assigned')
  findAssigned(@CurrentUser() user: { sub: string }) {
    return this.logisticsService.findAssignedTo(user.sub);
  }
}

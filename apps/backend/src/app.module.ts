import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';

import { AppController } from './app.controller.js';
import { AppService } from './app.service.js';
import { PrismaModule } from './prisma/prisma.module.js';
import { AuthModule } from './modules/auth/auth.module.js';
import { InputsModule } from './modules/inputs/inputs.module.js';
import { MarketPricesModule } from './modules/market-prices/market-prices.module.js';
import { ProduceModule } from './modules/produce/produce.module.js';
import { BuyersModule } from './modules/buyers/buyers.module.js';
import { OrdersModule } from './modules/orders/orders.module.js';
import { LogisticsModule } from './modules/logistics/logistics.module.js';
import { PaymentsModule } from './modules/payments/payments.module.js';
import { NotificationsModule } from './modules/notifications/notifications.module.js';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    PrismaModule,
    AuthModule,
    InputsModule,
    MarketPricesModule,
    ProduceModule,
    BuyersModule,
    OrdersModule,
    LogisticsModule,
    PaymentsModule,
    NotificationsModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}

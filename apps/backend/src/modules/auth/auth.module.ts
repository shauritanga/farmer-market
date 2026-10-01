import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';

import { AuthController } from './auth.controller.js';
import { AuthService } from './auth.service.js';
import { PhoneVerificationService } from './phone-verification.service.js';
import { VerificationProvider } from './verification-provider.service.js';

@Module({
  imports: [
    JwtModule.register({
      global: true,
      secret: process.env.JWT_SECRET ?? 'dev-secret-change-me',
    }),
  ],
  controllers: [AuthController],
  providers: [AuthService, PhoneVerificationService, VerificationProvider],
})
export class AuthModule {}

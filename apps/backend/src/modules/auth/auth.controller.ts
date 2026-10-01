import { Body, Controller, HttpCode, HttpStatus, Post } from '@nestjs/common';

import { AuthService } from './auth.service.js';
import { RegisterDto } from './dto/register.dto.js';
import { LoginDto } from './dto/login.dto.js';
import { SendCodeDto } from './dto/send-code.dto.js';
import { VerifyCodeDto } from './dto/verify-code.dto.js';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('send-code')
  @HttpCode(HttpStatus.OK)
  sendCode(@Body() dto: SendCodeDto) {
    return this.authService.sendVerificationCode(dto);
  }

  @Post('verify-code')
  @HttpCode(HttpStatus.OK)
  verifyCode(@Body() dto: VerifyCodeDto) {
    return this.authService.verifyCode(dto);
  }

  @Post('register')
  register(@Body() dto: RegisterDto) {
    return this.authService.register(dto);
  }

  @Post('login')
  @HttpCode(HttpStatus.OK)
  login(@Body() dto: LoginDto) {
    return this.authService.login(dto);
  }
}

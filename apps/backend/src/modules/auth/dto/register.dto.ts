import { Transform } from 'class-transformer';
import { IsEnum, IsOptional, IsPhoneNumber, IsString, MinLength } from 'class-validator';
import { Role } from '../../../generated/prisma/enums.js';
import { normalizePhoneNumber } from '../utils/normalize-phone.util.js';

export class RegisterDto {
  @Transform(({ value }) => normalizePhoneNumber(value))
  @IsPhoneNumber('TZ')
  phoneNumber!: string;

  @IsString()
  @MinLength(2)
  name!: string;

  @IsString()
  @MinLength(8)
  password!: string;

  // The one-time proof returned by POST /auth/verify-code — proves this
  // phone number was just verified. See PhoneVerificationService.consume.
  @IsString()
  proof!: string;

  // TODO: the mobile name -> phone -> code -> password -> role
  // registration flow always sends a role now, but keep this optional
  // (defaulting to FARMER in AuthService) for any other future caller.
  @IsOptional()
  @IsEnum(Role)
  role?: Role;
}

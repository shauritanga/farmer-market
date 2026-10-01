import { Transform } from 'class-transformer';
import { IsPhoneNumber, IsString } from 'class-validator';

import { normalizePhoneNumber } from '../utils/normalize-phone.util.js';

export class LoginDto {
  @Transform(({ value }) => normalizePhoneNumber(value))
  @IsPhoneNumber('TZ')
  phoneNumber!: string;

  @IsString()
  password!: string;
}

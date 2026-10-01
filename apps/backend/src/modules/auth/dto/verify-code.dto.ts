import { Transform } from 'class-transformer';
import { IsPhoneNumber, IsString, Length } from 'class-validator';

import { normalizePhoneNumber } from '../utils/normalize-phone.util.js';

export class VerifyCodeDto {
  @Transform(({ value }) => normalizePhoneNumber(value))
  @IsPhoneNumber('TZ')
  phoneNumber!: string;

  @IsString()
  @Length(6, 6)
  code!: string;
}

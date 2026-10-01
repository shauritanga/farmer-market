import { Transform } from 'class-transformer';
import { IsPhoneNumber } from 'class-validator';

import { normalizePhoneNumber } from '../utils/normalize-phone.util.js';

export class SendCodeDto {
  // Accepts +255712345678, 255712345678 or 0712345678 — normalized to
  // E.164 before validation. See normalize-phone.util.ts.
  @Transform(({ value }) => normalizePhoneNumber(value))
  @IsPhoneNumber('TZ')
  phoneNumber!: string;
}

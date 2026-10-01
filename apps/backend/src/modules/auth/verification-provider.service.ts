import { Injectable, ServiceUnavailableException } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

/**
 * Sends SMS via Beem (https://apisms.beem.africa) — same provider, same
 * request shape, and the same dev-mode bypass as the sibling RealMoney
 * project's `VerificationProvider` (apps/backend/src/onboarding). Kept
 * SMS-only here; RealMoney's identity/wallet verification isn't relevant
 * to this app.
 */
@Injectable()
export class VerificationProvider {
  constructor(private readonly config: ConfigService) {}

  get development() {
    return (
      this.config.get('NODE_ENV') !== 'production' &&
      this.config.get('ONBOARDING_DEV_MODE') === 'true'
    );
  }

  async sendSms(payload: { phone: string; message: string }) {
    if (this.development) {
      return { reference: `development-sms`, mode: 'development' as const };
    }

    const key = this.config.get<string>('BEEM_API_KEY');
    const secret = this.config.get<string>('BEEM_API_SECRET');
    const sender = this.config.get<string>('BEEM_SENDER_ID');
    if (!key || !secret || !sender) {
      throw new ServiceUnavailableException(
        'SMS verification is not configured',
      );
    }

    try {
      const response = await fetch('https://apisms.beem.africa/v1/send', {
        method: 'POST',
        redirect: 'error',
        signal: AbortSignal.timeout(10000),
        headers: {
          Authorization: `Basic ${Buffer.from(`${key}:${secret}`).toString('base64')}`,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          source_addr: sender,
          encoding: 0,
          message: payload.message,
          recipients: [
            { recipient_id: '1', dest_addr: payload.phone.replace(/^\+/, '') },
          ],
        }),
      });
      const data = (await response.json()) as {
        successful?: boolean;
        request_id?: string;
      };
      if (!response.ok || data.successful !== true) {
        throw new Error('SMS not accepted');
      }
      return {
        reference: String(data.request_id ?? ''),
        mode: 'live' as const,
      };
    } catch {
      throw new ServiceUnavailableException('SMS could not be sent. Please retry.');
    }
  }
}

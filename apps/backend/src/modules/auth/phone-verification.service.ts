import { createHmac, randomBytes, randomInt } from 'node:crypto';

import { BadRequestException, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';

import { PrismaService } from '../../prisma/prisma.service.js';
import { VerificationProvider } from './verification-provider.service.js';

const CODE_TTL_MS = 5 * 60 * 1000;
const PROOF_TTL_MS = 30 * 60 * 1000;
const RESEND_COOLDOWN_MS = 60 * 1000;
const MAX_ATTEMPTS = 5;

/**
 * Generate/store/verify/consume an SMS OTP, plus the "proof" hand-off used
 * to bind a verified phone to the registration call that follows — same
 * pattern as the sibling RealMoney project's onboarding
 * `PhoneVerificationService`, re-expressed against Prisma/Postgres instead
 * of TypeORM. Codes and proofs are stored only as HMAC-SHA256 hashes,
 * never in plain text.
 */
@Injectable()
export class PhoneVerificationService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly config: ConfigService,
    private readonly provider: VerificationProvider,
  ) {}

  private hash(value: string): string {
    const secret = this.config.get<string>('OTP_SECRET');
    return createHmac('sha256', secret || 'development-only-otp-secret')
      .update(value)
      .digest('hex');
  }

  async send(
    phoneNumber: string,
  ): Promise<{ sent: true; developmentCode?: string }> {
    const existing = await this.prisma.phoneVerification.findUnique({
      where: { phoneNumber },
    });
    if (existing && Date.now() - existing.sentAt.getTime() < RESEND_COOLDOWN_MS) {
      throw new BadRequestException('Please wait before requesting another code');
    }

    const code = String(randomInt(100000, 1000000));

    await this.provider.sendSms({
      phone: phoneNumber,
      message: `Your Fama verification code is ${code}. It expires in 5 minutes. Do not share it.`,
    });

    await this.prisma.phoneVerification.upsert({
      where: { phoneNumber },
      create: {
        phoneNumber,
        codeHash: this.hash(`${phoneNumber}:${code}`),
        expiresAt: new Date(Date.now() + CODE_TTL_MS),
        sentAt: new Date(),
        attempts: 0,
      },
      update: {
        codeHash: this.hash(`${phoneNumber}:${code}`),
        expiresAt: new Date(Date.now() + CODE_TTL_MS),
        sentAt: new Date(),
        attempts: 0,
        proofHash: null,
        verifiedAt: null,
      },
    });

    return {
      sent: true,
      ...(this.provider.development ? { developmentCode: code } : {}),
    };
  }

  /** Returns a one-time proof token the client must pass to `register()`. */
  async verify(phoneNumber: string, code: string): Promise<{ proof: string }> {
    const row = await this.prisma.phoneVerification.findUnique({
      where: { phoneNumber },
    });

    const invalid =
      !row ||
      row.expiresAt.getTime() < Date.now() ||
      row.attempts >= MAX_ATTEMPTS ||
      row.verifiedAt !== null;

    if (invalid) {
      throw new BadRequestException(
        'Code is invalid, expired or already used. Request a new code if needed.',
      );
    }

    if (row.codeHash !== this.hash(`${phoneNumber}:${code}`)) {
      await this.prisma.phoneVerification.update({
        where: { phoneNumber },
        data: { attempts: { increment: 1 } },
      });
      throw new BadRequestException(
        'Code is invalid, expired or already used. Request a new code if needed.',
      );
    }

    const proof = randomBytes(32).toString('hex');
    await this.prisma.phoneVerification.update({
      where: { phoneNumber },
      data: {
        codeHash: '',
        proofHash: this.hash(proof),
        verifiedAt: new Date(),
        expiresAt: new Date(Date.now() + PROOF_TTL_MS),
      },
    });

    return { proof };
  }

  /** Consumes the proof at registration time; throws if invalid/expired/reused. */
  async consume(phoneNumber: string, proof: string): Promise<void> {
    const row = await this.prisma.phoneVerification.findUnique({
      where: { phoneNumber },
    });

    const invalid =
      !row ||
      !row.verifiedAt ||
      row.expiresAt.getTime() < Date.now() ||
      row.proofHash !== this.hash(proof);

    if (invalid) {
      throw new BadRequestException(
        'Phone number not verified — request and verify a code first',
      );
    }

    await this.prisma.phoneVerification.delete({ where: { phoneNumber } });
  }
}

import {
  ConflictException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import * as bcrypt from 'bcryptjs';

import { PrismaService } from '../../prisma/prisma.service.js';
import { Role } from '../../generated/prisma/enums.js';
import { PhoneVerificationService } from './phone-verification.service.js';
import { RegisterDto } from './dto/register.dto.js';
import { LoginDto } from './dto/login.dto.js';
import { SendCodeDto } from './dto/send-code.dto.js';
import { VerifyCodeDto } from './dto/verify-code.dto.js';

const ACCESS_TOKEN_TTL = '15m';
const REFRESH_TOKEN_TTL = '30d';

@Injectable()
export class AuthService {
  constructor(
    private readonly prisma: PrismaService,
    private readonly jwt: JwtService,
    private readonly phoneVerification: PhoneVerificationService,
  ) {}

  sendVerificationCode(dto: SendCodeDto) {
    return this.phoneVerification.send(dto.phoneNumber);
  }

  verifyCode(dto: VerifyCodeDto) {
    return this.phoneVerification.verify(dto.phoneNumber, dto.code);
  }

  async register(dto: RegisterDto) {
    await this.phoneVerification.consume(dto.phoneNumber, dto.proof);

    const existing = await this.prisma.user.findUnique({
      where: { phoneNumber: dto.phoneNumber },
    });
    if (existing) {
      throw new ConflictException('Phone number already registered');
    }

    const passwordHash = await bcrypt.hash(dto.password, 10);
    const role = dto.role ?? Role.FARMER;

    // Every user needs their role's profile row — produce listings, orders,
    // etc. all resolve "the current farmer/buyer/transporter" through it,
    // not through User directly.
    const user = await this.prisma.$transaction(async (tx) => {
      const created = await tx.user.create({
        data: {
          phoneNumber: dto.phoneNumber,
          name: dto.name,
          role,
          passwordHash,
        },
      });

      switch (role) {
        case Role.FARMER:
          await tx.farmerProfile.create({ data: { userId: created.id } });
          break;
        case Role.BUYER:
          await tx.buyerProfile.create({ data: { userId: created.id } });
          break;
        case Role.TRANSPORTER:
          await tx.transporterProfile.create({ data: { userId: created.id } });
          break;
        case Role.ADMIN:
          break;
      }

      return created;
    });

    const { accessToken, refreshToken } = await this.issueSession(
      user.id,
      user.role,
    );

    return {
      user: {
        id: user.id,
        name: user.name,
        phoneNumber: user.phoneNumber,
        role: user.role,
      },
      accessToken,
      refreshToken,
    };
  }

  async login(dto: LoginDto) {
    const user = await this.prisma.user.findUnique({
      where: { phoneNumber: dto.phoneNumber },
    });
    if (!user) {
      throw new UnauthorizedException('Invalid phone number or password');
    }

    const passwordMatches = await bcrypt.compare(
      dto.password,
      user.passwordHash,
    );
    if (!passwordMatches) {
      throw new UnauthorizedException('Invalid phone number or password');
    }

    const { accessToken, refreshToken } = await this.issueSession(
      user.id,
      user.role,
    );

    return {
      user: {
        id: user.id,
        name: user.name,
        phoneNumber: user.phoneNumber,
        role: user.role,
      },
      accessToken,
      refreshToken,
    };
  }

  private async issueSession(userId: string, role: string) {
    const payload = { sub: userId, role };
    const [accessToken, refreshToken] = await Promise.all([
      this.jwt.signAsync(payload, { expiresIn: ACCESS_TOKEN_TTL }),
      this.jwt.signAsync(payload, { expiresIn: REFRESH_TOKEN_TTL }),
    ]);
    return { accessToken, refreshToken };
  }
}

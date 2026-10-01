import {
  BadRequestException,
  ForbiddenException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';

import { PrismaService } from '../../prisma/prisma.service.js';

@Injectable()
export class InputsService {
  constructor(private readonly prisma: PrismaService) {}

  /** Active catalog, grouped-by-category ordering for shelf-like display. */
  findActive() {
    return this.prisma.agroInput.findMany({
      where: { isActive: true },
      orderBy: [{ category: 'asc' }, { name: 'asc' }],
    });
  }

  /**
   * A farmer's order *request* — status starts at REQUESTED and stock is
   * not decremented here. Confirmation (and the stock decrement) is an
   * admin/supplier action to be added with the web dashboard.
   */
  async createOrder(userId: string, inputId: string, quantity: number) {
    if (!Number.isFinite(quantity) || quantity <= 0) {
      throw new BadRequestException('Quantity must be greater than zero.');
    }

    const farmer = await this.prisma.farmerProfile.findUnique({
      where: { userId },
    });
    if (!farmer) {
      throw new ForbiddenException('Only farmers can order inputs.');
    }

    const input = await this.prisma.agroInput.findUnique({
      where: { id: inputId },
    });
    if (!input || !input.isActive) {
      throw new NotFoundException('Input not found.');
    }
    if (input.stockQuantity != null && quantity > input.stockQuantity) {
      throw new BadRequestException(
        `Only ${input.stockQuantity} ${input.unit} in stock.`,
      );
    }

    return this.prisma.agroInputOrder.create({
      data: {
        farmerId: farmer.id,
        inputId: input.id,
        quantity,
        unitPrice: input.price,
      },
      include: { input: true },
    });
  }

  /** The calling farmer's own input orders, newest first. */
  findMine(userId: string) {
    return this.prisma.agroInputOrder.findMany({
      where: { farmer: { userId } },
      orderBy: { createdAt: 'desc' },
      include: { input: true },
    });
  }
}

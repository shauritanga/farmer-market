import { Injectable } from '@nestjs/common';

import { PrismaService } from '../../prisma/prisma.service.js';

@Injectable()
export class MarketPricesService {
  constructor(private readonly prisma: PrismaService) {}

  /**
   * Latest known price per commodity/market/grade combination. The API
   * always returns `recordedAt` and `priceType` alongside the price — see
   * docs/api/api-boundaries.md (Market Prices): "return freshness metadata
   * and source/type information with prices."
   */
  findCurrent(params: { commodityId?: string; marketId?: string }) {
    return this.prisma.marketPrice.findMany({
      where: {
        commodityId: params.commodityId,
        marketId: params.marketId,
      },
      orderBy: { recordedAt: 'desc' },
      take: 50,
      include: { commodity: true, market: true },
    });
  }

  /**
   * The Home tab's "top 10 products in the top market" — "top market" is
   * derived from data (the market with the most recorded prices), never
   * hardcoded to a market name, so this stays correct if the reference
   * data changes. Up to 10 distinct commodities, latest price each.
   */
  async findTopMarket() {
    const [topGroup] = await this.prisma.marketPrice.groupBy({
      by: ['marketId'],
      _count: { marketId: true },
      orderBy: { _count: { marketId: 'desc' } },
      take: 1,
    });

    if (!topGroup) {
      return { market: null, prices: [] };
    }

    const market = await this.prisma.market.findUniqueOrThrow({
      where: { id: topGroup.marketId },
    });

    const prices = await this.prisma.marketPrice.findMany({
      where: { marketId: market.id },
      orderBy: [{ commodityId: 'asc' }, { recordedAt: 'desc' }],
      distinct: ['commodityId'],
      take: 10,
      include: { commodity: true, market: true },
    });
    prices.sort((a, b) => b.recordedAt.getTime() - a.recordedAt.getTime());

    return {
      market: { id: market.id, name: market.name, region: market.region },
      prices,
    };
  }
}

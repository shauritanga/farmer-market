// Local/dev-only sample data — commodities, markets, and a handful of
// market prices so the mobile app's Market tab has something real to
// render while testing. None of this is real market data; every row here
// is clearly fictitious and must never be treated as a real price feed.
import { PrismaPg } from '@prisma/adapter-pg';

// Imports the *compiled* client (run `npm run build` first) rather than
// `src/generated/prisma/client.ts` — this script runs as plain Node with
// type-stripping, which can't follow that file's internal `.js`-extension
// imports back to their TypeScript sources the way `tsc`/nest's build does.
import { PrismaClient } from '../dist/generated/prisma/client.js';

const prisma = new PrismaClient({
  adapter: new PrismaPg({ connectionString: process.env.DATABASE_URL }),
});

async function main() {
  const commodities = await Promise.all(
    [
      { name: 'Maize', unit: 'kg' },
      { name: 'Rice', unit: 'kg' },
      { name: 'Beans', unit: 'kg' },
      { name: 'Tomatoes', unit: 'kg' },
    ].map((c) =>
      prisma.commodity.upsert({
        where: { name: c.name },
        create: c,
        update: {},
      }),
    ),
  );

  const markets = await Promise.all(
    [
      { name: 'Kariakoo Market', region: 'Dar es Salaam' },
      { name: 'Arusha Central Market', region: 'Arusha' },
      { name: 'Mwanza Market', region: 'Mwanza' },
    ].map((m) =>
      prisma.market.upsert({
        where: { name_region: { name: m.name, region: m.region } },
        create: m,
        update: {},
      }),
    ),
  );

  const [maize, rice, beans, tomatoes] = commodities;
  const [kariakoo, arusha, mwanza] = markets;

  const samplePrices: {
    commodityId: string;
    marketId: string;
    price: number;
    unit: string;
  }[] = [
    { commodityId: maize.id, marketId: kariakoo.id, price: 900, unit: 'kg' },
    { commodityId: maize.id, marketId: arusha.id, price: 850, unit: 'kg' },
    { commodityId: rice.id, marketId: kariakoo.id, price: 2600, unit: 'kg' },
    { commodityId: beans.id, marketId: mwanza.id, price: 2100, unit: 'kg' },
    {
      commodityId: tomatoes.id,
      marketId: kariakoo.id,
      price: 1200,
      unit: 'kg',
    },
  ];

  for (const p of samplePrices) {
    await prisma.marketPrice.create({
      data: {
        commodityId: p.commodityId,
        marketId: p.marketId,
        price: p.price,
        unit: p.unit,
        currency: 'TZS',
        priceType: 'REPORTED',
        source: 'seed-sample-data',
        recordedAt: new Date(),
      },
    });
  }

  const sampleInputs = [
    {
      name: 'Maize Seed (Hybrid)',
      category: 'SEED',
      unit: 'bag',
      price: 45000,
      stockQuantity: 120,
      supplierName: 'Agro Supply Co.',
      description: 'High-yield hybrid maize seed, 10kg bag.',
    },
    {
      name: 'Urea Fertilizer',
      category: 'FERTILIZER',
      unit: 'bag',
      price: 85000,
      stockQuantity: 200,
      supplierName: 'Agro Supply Co.',
      description: 'Nitrogen fertilizer, 50kg bag.',
    },
    {
      name: 'DAP Fertilizer',
      category: 'FERTILIZER',
      unit: 'bag',
      price: 95000,
      stockQuantity: 150,
      supplierName: 'Agro Supply Co.',
      description: 'Planting fertilizer, 50kg bag.',
    },
    {
      name: 'Pesticide (General)',
      category: 'PESTICIDE',
      unit: 'litre',
      price: 28000,
      stockQuantity: 80,
      supplierName: 'CropCare Ltd.',
      description: 'Broad-spectrum crop pesticide, 1 litre.',
    },
  ];

  for (const input of sampleInputs) {
    const existing = await prisma.agroInput.findFirst({
      where: { name: input.name },
    });
    if (!existing) {
      await prisma.agroInput.create({ data: { ...input, currency: 'TZS' } });
    }
  }

  console.log(
    `Seeded ${commodities.length} commodities, ${markets.length} markets, ${samplePrices.length} sample prices, ${sampleInputs.length} sample inputs.`,
  );
}

main()
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

-- CreateEnum
CREATE TYPE "Role" AS ENUM ('FARMER', 'BUYER', 'TRANSPORTER', 'ADMIN');

-- CreateEnum
CREATE TYPE "PriceType" AS ENUM ('INDICATIVE', 'REPORTED', 'BUYER_OFFER', 'COMPLETED_TRANSACTION');

-- CreateEnum
CREATE TYPE "ListingStatus" AS ENUM ('ACTIVE', 'PAUSED', 'SOLD_OUT', 'CLOSED');

-- CreateEnum
CREATE TYPE "DemandStatus" AS ENUM ('OPEN', 'MATCHED', 'CLOSED');

-- CreateEnum
CREATE TYPE "OfferStatus" AS ENUM ('PENDING', 'ACCEPTED', 'REJECTED', 'WITHDRAWN');

-- CreateEnum
CREATE TYPE "OrderStatus" AS ENUM ('CREATED', 'ACCEPTED', 'PREPARING', 'PICKED_UP', 'IN_TRANSIT', 'DELIVERED', 'VERIFIED', 'PAID', 'COMPLETED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "TransportStatus" AS ENUM ('REQUESTED', 'ASSIGNED', 'PICKED_UP', 'IN_TRANSIT', 'DELIVERED', 'FAILED');

-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('EXPECTED', 'PENDING', 'CONFIRMED', 'FAILED', 'REFUNDED', 'REVERSED');

-- CreateEnum
CREATE TYPE "NotificationType" AS ENUM ('PRICE_ALERT', 'DEMAND_MATCH', 'OFFER_RECEIVED', 'OFFER_ACCEPTED', 'ORDER_UPDATE', 'TRANSPORTER_ASSIGNED', 'PICKUP_CONFIRMED', 'DELIVERY_CONFIRMED', 'PAYMENT_CONFIRMED');

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "passwordHash" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "role" "Role" NOT NULL,
    "isVerified" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "farmer_profiles" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,

    CONSTRAINT "farmer_profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "buyer_profiles" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "businessName" TEXT,

    CONSTRAINT "buyer_profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transporter_profiles" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "vehicleType" TEXT,
    "vehiclePlate" TEXT,

    CONSTRAINT "transporter_profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "commodities" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "unit" TEXT NOT NULL,

    CONSTRAINT "commodities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "markets" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "region" TEXT NOT NULL,

    CONSTRAINT "markets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "farms" (
    "id" TEXT NOT NULL,
    "farmerId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "sizeHectares" DOUBLE PRECISION,

    CONSTRAINT "farms_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "crops" (
    "id" TEXT NOT NULL,
    "farmId" TEXT NOT NULL,
    "commodityId" TEXT NOT NULL,
    "plantedArea" DOUBLE PRECISION,
    "expectedHarvestDate" TIMESTAMP(3),

    CONSTRAINT "crops_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "market_prices" (
    "id" TEXT NOT NULL,
    "commodityId" TEXT NOT NULL,
    "marketId" TEXT NOT NULL,
    "grade" TEXT,
    "price" DECIMAL(65,30) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'TZS',
    "unit" TEXT NOT NULL,
    "priceType" "PriceType" NOT NULL,
    "source" TEXT NOT NULL,
    "recordedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "market_prices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "produce_listings" (
    "id" TEXT NOT NULL,
    "farmerId" TEXT NOT NULL,
    "commodityId" TEXT NOT NULL,
    "quantityAvailable" DOUBLE PRECISION NOT NULL,
    "unit" TEXT NOT NULL,
    "grade" TEXT,
    "location" TEXT NOT NULL,
    "availableFrom" TIMESTAMP(3) NOT NULL,
    "expectedPrice" DECIMAL(65,30),
    "isNegotiable" BOOLEAN NOT NULL DEFAULT true,
    "status" "ListingStatus" NOT NULL DEFAULT 'ACTIVE',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "produce_listings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "buyer_demands" (
    "id" TEXT NOT NULL,
    "buyerId" TEXT NOT NULL,
    "commodityId" TEXT NOT NULL,
    "quantity" DOUBLE PRECISION NOT NULL,
    "unit" TEXT NOT NULL,
    "grade" TEXT,
    "targetLocation" TEXT NOT NULL,
    "offerPrice" DECIMAL(65,30),
    "requiredBy" TIMESTAMP(3) NOT NULL,
    "paymentTerms" TEXT,
    "status" "DemandStatus" NOT NULL DEFAULT 'OPEN',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "buyer_demands_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "offers" (
    "id" TEXT NOT NULL,
    "produceListingId" TEXT,
    "buyerDemandId" TEXT,
    "fromUserId" TEXT NOT NULL,
    "toUserId" TEXT NOT NULL,
    "quantity" DOUBLE PRECISION NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "status" "OfferStatus" NOT NULL DEFAULT 'PENDING',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "offers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orders" (
    "id" TEXT NOT NULL,
    "buyerId" TEXT NOT NULL,
    "farmerId" TEXT NOT NULL,
    "produceListingId" TEXT,
    "offerId" TEXT,
    "commodityId" TEXT NOT NULL,
    "quantity" DOUBLE PRECISION NOT NULL,
    "unit" TEXT NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "grade" TEXT,
    "pickupLocation" TEXT NOT NULL,
    "deliveryLocation" TEXT NOT NULL,
    "paymentTerms" TEXT,
    "status" "OrderStatus" NOT NULL DEFAULT 'CREATED',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order_status_events" (
    "id" TEXT NOT NULL,
    "orderId" TEXT NOT NULL,
    "status" "OrderStatus" NOT NULL,
    "note" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "order_status_events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transport_jobs" (
    "id" TEXT NOT NULL,
    "orderId" TEXT NOT NULL,
    "transporterId" TEXT,
    "cargoDescription" TEXT NOT NULL,
    "pickupLocation" TEXT NOT NULL,
    "destination" TEXT NOT NULL,
    "vehicleInfo" TEXT,
    "status" "TransportStatus" NOT NULL DEFAULT 'REQUESTED',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "transport_jobs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transport_events" (
    "id" TEXT NOT NULL,
    "transportJobId" TEXT NOT NULL,
    "status" "TransportStatus" NOT NULL,
    "proofUrl" TEXT,
    "note" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "transport_events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payments" (
    "id" TEXT NOT NULL,
    "orderId" TEXT NOT NULL,
    "amount" DECIMAL(65,30) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'TZS',
    "status" "PaymentStatus" NOT NULL DEFAULT 'EXPECTED',
    "provider" TEXT,
    "providerReference" TEXT,
    "initiatedAt" TIMESTAMP(3),
    "confirmedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "payments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notifications" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "type" "NotificationType" NOT NULL,
    "title" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "isRead" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "notifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "transactions" (
    "id" TEXT NOT NULL,
    "orderId" TEXT NOT NULL,
    "buyerId" TEXT NOT NULL,
    "farmerId" TEXT NOT NULL,
    "commodityId" TEXT NOT NULL,
    "quantity" DOUBLE PRECISION NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "completedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "transactions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_phoneNumber_key" ON "users"("phoneNumber");

-- CreateIndex
CREATE UNIQUE INDEX "farmer_profiles_userId_key" ON "farmer_profiles"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "buyer_profiles_userId_key" ON "buyer_profiles"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "transporter_profiles_userId_key" ON "transporter_profiles"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "commodities_name_key" ON "commodities"("name");

-- CreateIndex
CREATE UNIQUE INDEX "markets_name_region_key" ON "markets"("name", "region");

-- CreateIndex
CREATE INDEX "farms_farmerId_idx" ON "farms"("farmerId");

-- CreateIndex
CREATE INDEX "crops_farmId_idx" ON "crops"("farmId");

-- CreateIndex
CREATE INDEX "market_prices_commodityId_marketId_recordedAt_idx" ON "market_prices"("commodityId", "marketId", "recordedAt");

-- CreateIndex
CREATE INDEX "produce_listings_farmerId_idx" ON "produce_listings"("farmerId");

-- CreateIndex
CREATE INDEX "produce_listings_commodityId_status_idx" ON "produce_listings"("commodityId", "status");

-- CreateIndex
CREATE INDEX "buyer_demands_buyerId_idx" ON "buyer_demands"("buyerId");

-- CreateIndex
CREATE INDEX "buyer_demands_commodityId_status_idx" ON "buyer_demands"("commodityId", "status");

-- CreateIndex
CREATE INDEX "offers_produceListingId_idx" ON "offers"("produceListingId");

-- CreateIndex
CREATE INDEX "offers_buyerDemandId_idx" ON "offers"("buyerDemandId");

-- CreateIndex
CREATE UNIQUE INDEX "orders_offerId_key" ON "orders"("offerId");

-- CreateIndex
CREATE INDEX "orders_buyerId_idx" ON "orders"("buyerId");

-- CreateIndex
CREATE INDEX "orders_farmerId_idx" ON "orders"("farmerId");

-- CreateIndex
CREATE INDEX "order_status_events_orderId_idx" ON "order_status_events"("orderId");

-- CreateIndex
CREATE UNIQUE INDEX "transport_jobs_orderId_key" ON "transport_jobs"("orderId");

-- CreateIndex
CREATE INDEX "transport_jobs_transporterId_idx" ON "transport_jobs"("transporterId");

-- CreateIndex
CREATE INDEX "transport_events_transportJobId_idx" ON "transport_events"("transportJobId");

-- CreateIndex
CREATE UNIQUE INDEX "payments_orderId_key" ON "payments"("orderId");

-- CreateIndex
CREATE INDEX "notifications_userId_isRead_idx" ON "notifications"("userId", "isRead");

-- CreateIndex
CREATE UNIQUE INDEX "transactions_orderId_key" ON "transactions"("orderId");

-- CreateIndex
CREATE INDEX "transactions_buyerId_idx" ON "transactions"("buyerId");

-- CreateIndex
CREATE INDEX "transactions_farmerId_idx" ON "transactions"("farmerId");

-- AddForeignKey
ALTER TABLE "farmer_profiles" ADD CONSTRAINT "farmer_profiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "buyer_profiles" ADD CONSTRAINT "buyer_profiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transporter_profiles" ADD CONSTRAINT "transporter_profiles_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "farms" ADD CONSTRAINT "farms_farmerId_fkey" FOREIGN KEY ("farmerId") REFERENCES "farmer_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crops" ADD CONSTRAINT "crops_farmId_fkey" FOREIGN KEY ("farmId") REFERENCES "farms"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "crops" ADD CONSTRAINT "crops_commodityId_fkey" FOREIGN KEY ("commodityId") REFERENCES "commodities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "market_prices" ADD CONSTRAINT "market_prices_commodityId_fkey" FOREIGN KEY ("commodityId") REFERENCES "commodities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "market_prices" ADD CONSTRAINT "market_prices_marketId_fkey" FOREIGN KEY ("marketId") REFERENCES "markets"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "produce_listings" ADD CONSTRAINT "produce_listings_farmerId_fkey" FOREIGN KEY ("farmerId") REFERENCES "farmer_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "produce_listings" ADD CONSTRAINT "produce_listings_commodityId_fkey" FOREIGN KEY ("commodityId") REFERENCES "commodities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "buyer_demands" ADD CONSTRAINT "buyer_demands_buyerId_fkey" FOREIGN KEY ("buyerId") REFERENCES "buyer_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "buyer_demands" ADD CONSTRAINT "buyer_demands_commodityId_fkey" FOREIGN KEY ("commodityId") REFERENCES "commodities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "offers" ADD CONSTRAINT "offers_produceListingId_fkey" FOREIGN KEY ("produceListingId") REFERENCES "produce_listings"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "offers" ADD CONSTRAINT "offers_buyerDemandId_fkey" FOREIGN KEY ("buyerDemandId") REFERENCES "buyer_demands"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_buyerId_fkey" FOREIGN KEY ("buyerId") REFERENCES "buyer_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_farmerId_fkey" FOREIGN KEY ("farmerId") REFERENCES "farmer_profiles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_produceListingId_fkey" FOREIGN KEY ("produceListingId") REFERENCES "produce_listings"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_offerId_fkey" FOREIGN KEY ("offerId") REFERENCES "offers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "orders" ADD CONSTRAINT "orders_commodityId_fkey" FOREIGN KEY ("commodityId") REFERENCES "commodities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "order_status_events" ADD CONSTRAINT "order_status_events_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transport_jobs" ADD CONSTRAINT "transport_jobs_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transport_jobs" ADD CONSTRAINT "transport_jobs_transporterId_fkey" FOREIGN KEY ("transporterId") REFERENCES "transporter_profiles"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transport_events" ADD CONSTRAINT "transport_events_transportJobId_fkey" FOREIGN KEY ("transportJobId") REFERENCES "transport_jobs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transactions" ADD CONSTRAINT "transactions_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "orders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

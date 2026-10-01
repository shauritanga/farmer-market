-- CreateEnum
CREATE TYPE "AgroInputOrderStatus" AS ENUM ('REQUESTED', 'CONFIRMED', 'DELIVERED', 'CANCELLED');

-- CreateTable
CREATE TABLE "agro_inputs" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "unit" TEXT NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'TZS',
    "stockQuantity" DOUBLE PRECISION,
    "supplierName" TEXT,
    "description" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "agro_inputs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "agro_input_orders" (
    "id" TEXT NOT NULL,
    "farmerId" TEXT NOT NULL,
    "inputId" TEXT NOT NULL,
    "quantity" DOUBLE PRECISION NOT NULL,
    "unitPrice" DECIMAL(65,30) NOT NULL,
    "status" "AgroInputOrderStatus" NOT NULL DEFAULT 'REQUESTED',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "agro_input_orders_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "agro_inputs_category_isActive_idx" ON "agro_inputs"("category", "isActive");

-- CreateIndex
CREATE INDEX "agro_input_orders_farmerId_idx" ON "agro_input_orders"("farmerId");

-- AddForeignKey
ALTER TABLE "agro_input_orders" ADD CONSTRAINT "agro_input_orders_farmerId_fkey" FOREIGN KEY ("farmerId") REFERENCES "farmer_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "agro_input_orders" ADD CONSTRAINT "agro_input_orders_inputId_fkey" FOREIGN KEY ("inputId") REFERENCES "agro_inputs"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

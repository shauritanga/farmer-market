-- CreateTable
CREATE TABLE "phone_verifications" (
    "phoneNumber" TEXT NOT NULL,
    "codeHash" TEXT NOT NULL,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "sentAt" TIMESTAMP(3) NOT NULL,
    "attempts" INTEGER NOT NULL DEFAULT 0,
    "proofHash" TEXT,
    "verifiedAt" TIMESTAMP(3),

    CONSTRAINT "phone_verifications_pkey" PRIMARY KEY ("phoneNumber")
);

/*
  Warnings:

  - You are about to drop the `Subscription` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "PaymentStatus" AS ENUM ('PENDING', 'COMPLETED', 'FAILED', 'REFUNDED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "PlanType" AS ENUM ('YEARLY', 'FOUR_YEAR', 'LIFETIME');

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "Membership" ADD VALUE 'PREMIUM_YEARLY';
ALTER TYPE "Membership" ADD VALUE 'PREMIUM_4_YEAR';
ALTER TYPE "Membership" ADD VALUE 'PREMIUM_LIFETIME';

-- DropForeignKey
ALTER TABLE "Subscription" DROP CONSTRAINT "Subscription_candidateId_fkey";

-- AlterTable
ALTER TABLE "candidate_profiles" ADD COLUMN     "membershipExpiresAt" TIMESTAMP(3);

-- DropTable
DROP TABLE "Subscription";

-- CreateTable
CREATE TABLE "membership_orders" (
    "id" TEXT NOT NULL,
    "candidateId" TEXT NOT NULL,
    "planType" "PlanType" NOT NULL,
    "planName" TEXT NOT NULL,
    "razorpayOrderId" TEXT,
    "razorpayPaymentId" TEXT,
    "razorpaySignature" TEXT,
    "status" "PaymentStatus" NOT NULL DEFAULT 'PENDING',
    "amount" INTEGER NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'INR',
    "startsAt" TIMESTAMP(3),
    "expiresAt" TIMESTAMP(3),
    "isActive" BOOLEAN NOT NULL DEFAULT false,
    "isCollegeRegistered" BOOLEAN NOT NULL,
    "originalPrice" INTEGER NOT NULL,
    "discountApplied" INTEGER,
    "failureReason" TEXT,
    "notes" TEXT,
    "webhookProcessed" BOOLEAN NOT NULL DEFAULT false,
    "lastWebhookAt" TIMESTAMP(3),
    "webhookData" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "membership_orders_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "membership_orders_razorpayOrderId_key" ON "membership_orders"("razorpayOrderId");

-- CreateIndex
CREATE UNIQUE INDEX "membership_orders_razorpayPaymentId_key" ON "membership_orders"("razorpayPaymentId");

-- CreateIndex
CREATE INDEX "membership_orders_candidateId_idx" ON "membership_orders"("candidateId");

-- CreateIndex
CREATE INDEX "membership_orders_status_idx" ON "membership_orders"("status");

-- CreateIndex
CREATE INDEX "membership_orders_razorpayOrderId_idx" ON "membership_orders"("razorpayOrderId");

-- CreateIndex
CREATE INDEX "membership_orders_razorpayPaymentId_idx" ON "membership_orders"("razorpayPaymentId");

-- CreateIndex
CREATE INDEX "membership_orders_isActive_expiresAt_idx" ON "membership_orders"("isActive", "expiresAt");

-- CreateIndex
CREATE INDEX "membership_orders_webhookProcessed_idx" ON "membership_orders"("webhookProcessed");

-- CreateIndex
CREATE INDEX "membership_orders_createdAt_idx" ON "membership_orders"("createdAt");

-- CreateIndex
CREATE INDEX "membership_orders_planType_idx" ON "membership_orders"("planType");

-- CreateIndex
CREATE INDEX "candidate_profiles_membership_idx" ON "candidate_profiles"("membership");

-- CreateIndex
CREATE INDEX "candidate_profiles_membershipExpiresAt_idx" ON "candidate_profiles"("membershipExpiresAt");

-- AddForeignKey
ALTER TABLE "membership_orders" ADD CONSTRAINT "membership_orders_candidateId_fkey" FOREIGN KEY ("candidateId") REFERENCES "candidate_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

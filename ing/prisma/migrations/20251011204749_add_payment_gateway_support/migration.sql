/*
  Warnings:

  - A unique constraint covering the columns `[phonePeTransactionId]` on the table `membership_orders` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "PaymentGateway" AS ENUM ('RAZORPAY', 'PHONEPE');

-- AlterTable
ALTER TABLE "membership_orders" ADD COLUMN     "paymentGateway" "PaymentGateway" NOT NULL DEFAULT 'PHONEPE',
ADD COLUMN     "phonePeMerchantTransactionId" TEXT,
ADD COLUMN     "phonePeTransactionId" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "membership_orders_phonePeTransactionId_key" ON "membership_orders"("phonePeTransactionId");

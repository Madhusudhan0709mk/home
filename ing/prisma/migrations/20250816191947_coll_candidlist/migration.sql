-- CreateEnum
CREATE TYPE "public"."Membership" AS ENUM ('FREE', 'SUBSCRIBED');

-- AlterTable
ALTER TABLE "public"."candidate_profiles" ADD COLUMN     "membership" "public"."Membership" NOT NULL DEFAULT 'FREE';

-- CreateTable
CREATE TABLE "public"."Subscription" (
    "id" TEXT NOT NULL,
    "candidateId" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL,
    "endDate" TIMESTAMP(3),
    "paymentId" TEXT,

    CONSTRAINT "Subscription_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "public"."Subscription" ADD CONSTRAINT "Subscription_candidateId_fkey" FOREIGN KEY ("candidateId") REFERENCES "public"."candidate_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

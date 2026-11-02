/*
  Warnings:

  - The values [PENDING,REVIEWED,ACCEPTED] on the enum `ApplicationStatus` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the `ApplicationGroup` table. If the table is not empty, all the data it contains will be lost.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "ApplicationStatus_new" AS ENUM ('APPLIED', 'SCREENING', 'PHONE_SCREEN', 'TECHNICAL', 'FINAL_INTERVIEW', 'OFFERED', 'HIRED', 'REJECTED');
ALTER TABLE "Application" ALTER COLUMN "status" DROP DEFAULT;
ALTER TABLE "Application" ALTER COLUMN "status" TYPE "ApplicationStatus_new" USING ("status"::text::"ApplicationStatus_new");
ALTER TYPE "ApplicationStatus" RENAME TO "ApplicationStatus_old";
ALTER TYPE "ApplicationStatus_new" RENAME TO "ApplicationStatus";
DROP TYPE "ApplicationStatus_old";
ALTER TABLE "Application" ALTER COLUMN "status" SET DEFAULT 'APPLIED';
COMMIT;

-- DropForeignKey
ALTER TABLE "ApplicationGroup" DROP CONSTRAINT "ApplicationGroup_recruiterId_fkey";

-- AlterTable
ALTER TABLE "Application" ADD COLUMN     "notes" TEXT,
ALTER COLUMN "status" SET DEFAULT 'APPLIED';

-- DropTable
DROP TABLE "ApplicationGroup";

-- CreateIndex
CREATE INDEX "Application_status_idx" ON "Application"("status");

-- CreateIndex
CREATE INDEX "Application_appliedAt_idx" ON "Application"("appliedAt");

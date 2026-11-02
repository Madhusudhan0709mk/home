/*
  Warnings:

  - You are about to drop the column `isActive` on the `candidate_profiles` table. All the data in the column will be lost.
  - You are about to drop the column `last_updated` on the `candidate_profiles` table. All the data in the column will be lost.
  - You are about to drop the column `profileCompleteness` on the `candidate_profiles` table. All the data in the column will be lost.
  - You are about to drop the column `profile_id` on the `educations` table. All the data in the column will be lost.
  - You are about to drop the column `profile_id` on the `experiences` table. All the data in the column will be lost.
  - The `experienceType` column on the `experiences` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Added the required column `profileId` to the `educations` table without a default value. This is not possible if the table is not empty.
  - Made the column `grade` on table `educations` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `profileId` to the `experiences` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "educations" DROP CONSTRAINT "educations_profile_id_fkey";

-- DropForeignKey
ALTER TABLE "experiences" DROP CONSTRAINT "experiences_profile_id_fkey";

-- DropIndex
DROP INDEX "educations_profile_id_current_idx";

-- DropIndex
DROP INDEX "educations_profile_id_idx";

-- DropIndex
DROP INDEX "experiences_profile_id_current_idx";

-- DropIndex
DROP INDEX "experiences_profile_id_idx";

-- AlterTable
ALTER TABLE "candidate_profiles" DROP COLUMN "isActive",
DROP COLUMN "last_updated",
DROP COLUMN "profileCompleteness",
ALTER COLUMN "phone" SET DATA TYPE TEXT,
ALTER COLUMN "location" SET DATA TYPE TEXT,
ALTER COLUMN "linkedin" SET DATA TYPE TEXT,
ALTER COLUMN "minimumPay" SET DATA TYPE TEXT,
ALTER COLUMN "currentLocation" SET DATA TYPE TEXT,
ALTER COLUMN "hometown" SET DATA TYPE TEXT,
ALTER COLUMN "preferredLocations" DROP DEFAULT,
ALTER COLUMN "preferredJobTitles" DROP DEFAULT,
ALTER COLUMN "languages" DROP DEFAULT;

-- AlterTable
ALTER TABLE "educations" DROP COLUMN "profile_id",
ADD COLUMN     "profileId" TEXT NOT NULL,
ALTER COLUMN "degree" SET DATA TYPE TEXT,
ALTER COLUMN "institution" SET DATA TYPE TEXT,
ALTER COLUMN "location" SET DATA TYPE TEXT,
ALTER COLUMN "startDate" SET DATA TYPE TEXT,
ALTER COLUMN "endDate" SET DATA TYPE TEXT,
ALTER COLUMN "grade" SET NOT NULL,
ALTER COLUMN "grade" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "experiences" DROP COLUMN "profile_id",
ADD COLUMN     "profileId" TEXT NOT NULL,
ALTER COLUMN "title" SET DATA TYPE TEXT,
ALTER COLUMN "company" SET DATA TYPE TEXT,
ALTER COLUMN "location" SET DATA TYPE TEXT,
ALTER COLUMN "startDate" SET DATA TYPE TEXT,
ALTER COLUMN "endDate" SET DATA TYPE TEXT,
DROP COLUMN "experienceType",
ADD COLUMN     "experienceType" TEXT;

-- AlterTable
ALTER TABLE "skills" ALTER COLUMN "name" SET DATA TYPE TEXT;

-- CreateIndex
CREATE INDEX "educations_profileId_idx" ON "educations"("profileId");

-- CreateIndex
CREATE INDEX "educations_profileId_current_idx" ON "educations"("profileId", "current");

-- CreateIndex
CREATE INDEX "experiences_profileId_idx" ON "experiences"("profileId");

-- CreateIndex
CREATE INDEX "experiences_profileId_current_idx" ON "experiences"("profileId", "current");

-- CreateIndex
CREATE INDEX "experiences_experienceType_idx" ON "experiences"("experienceType");

-- AddForeignKey
ALTER TABLE "educations" ADD CONSTRAINT "educations_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "candidate_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "experiences" ADD CONSTRAINT "experiences_profileId_fkey" FOREIGN KEY ("profileId") REFERENCES "candidate_profiles"("id") ON DELETE CASCADE ON UPDATE CASCADE;

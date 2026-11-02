/*
  Warnings:

  - You are about to drop the column `blockedCompanies` on the `CandidateProfile` table. All the data in the column will be lost.
  - Added the required column `updatedAt` to the `RecruiterProfile` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "CandidateProfile" DROP COLUMN "blockedCompanies";

-- AlterTable
ALTER TABLE "RecruiterProfile" ADD COLUMN     "activeJobCount" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "applicationCount" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "hiringRate" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "industry" TEXT,
ADD COLUMN     "interviewCount" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "linkedinUrl" TEXT,
ADD COLUMN     "twitterHandle" TEXT,
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

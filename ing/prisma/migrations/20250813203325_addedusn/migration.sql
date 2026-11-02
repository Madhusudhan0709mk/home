/*
  Warnings:

  - A unique constraint covering the columns `[uniqueCollegeId]` on the table `candidate_profiles` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE "candidate_profiles" ADD COLUMN     "uniqueCollegeId" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "candidate_profiles_uniqueCollegeId_key" ON "candidate_profiles"("uniqueCollegeId");

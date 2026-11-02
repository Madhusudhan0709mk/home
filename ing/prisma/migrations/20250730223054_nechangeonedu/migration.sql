/*
  Warnings:

  - You are about to drop the column `educationLevel` on the `CandidateProfile` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "CandidateProfile" DROP COLUMN "educationLevel";

-- AlterTable
ALTER TABLE "Education" ADD COLUMN     "educationLevel" "EducationLevel";

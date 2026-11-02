-- DropForeignKey
ALTER TABLE "Application" DROP CONSTRAINT "Application_candidateId_fkey";

-- AlterTable
ALTER TABLE "RecruiterProfile" ADD COLUMN     "recruiterNumber" TEXT,
ADD COLUMN     "workLocation" TEXT;

-- AddForeignKey
ALTER TABLE "Application" ADD CONSTRAINT "Application_candidateId_fkey" FOREIGN KEY ("candidateId") REFERENCES "CandidateProfile"("id") ON DELETE CASCADE ON UPDATE CASCADE;
